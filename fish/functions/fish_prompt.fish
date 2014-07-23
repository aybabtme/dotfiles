function __git_ps1
  set -l g (git rev-parse --git-dir ^/dev/null)
  if [ -n "$g" ]
    set -l r ""
    set -l b ""

    if [ -d "$g/../.dotest" ]
      if [ -f "$g/../.dotest/rebasing" ]
        set r "|REBASE"
      elseif [ -f "$g/../.dotest/applying" ]
        set r "|AM"
      else
        set r "|AM/REBASE"
      end

      set b (git symbolic-ref HEAD ^/dev/null)
    elseif [ -f "$g/.dotest-merge/interactive" ]
      set r "|REBASE-i"
      set b (cat "$g/.dotest-merge/head-name")
    elseif [ -d "$g/.dotest-merge" ]
      set r "|REBASE-m"
      set b (cat "$g/.dotest-merge/head-name")
    elseif [ -f "$g/MERGE_HEAD" ]
      set r "|MERGING"
      set b (git symbolic-ref HEAD ^/dev/null)
    else
      if [ -f "$g/BISECT_LOG" ]
        set r "|BISECTING"
      end

      set b (git symbolic-ref HEAD ^/dev/null)
      if [ -z $b ]
        set b (git describe --exact-match HEAD ^/dev/null)
        if [ -z $b ]
          set b (cut -c1-7 "$g/HEAD")
          set b "$b..."
        end
      end
    end

    if not test $argv
        set argv " (%s)"
    end

    set b (echo $b | sed -e 's|^refs/heads/||')

    printf $argv "$b$r" ^/dev/null
  end
end


function fish_prompt -d "Write out the prompt"
  # Print arrow with exit status coloring
  if test $status = 0
    set ARROW_COLOR brown
  else
    set ARROW_COLOR red
  end

  # Hostname
  if not set -q HOST_COLOR
    set HOST_COLOR magenta
  end

  printf '%s%s' (set_color $HOST_COLOR) (hostname -s)

  # Color writeable dirs green, read-only dirs red
  if test -w "."
      printf ' %s%s' (set_color blue) (prompt_pwd)
  else
      printf ' %s%s' (set_color red) (prompt_pwd)
  end

  # spit out virtual env
  if set -q VIRTUAL_ENV
    printf ' %s%s' (set_color brown) (basename "$VIRTUAL_ENV")
  end

  # spit out virtual env
  if set -q HADOOP_ENV
    printf ' %s%s' (set_color magenta) $HADOOP_ENV
  end

  # Print git branch
  printf '%s%s' (set_color green) (__git_ps1)

  printf '%s ➜  %s' (set_color -o $ARROW_COLOR) (set_color normal)
end
