#命令操作审计
/etc/bashrc:
  file.append:
  - text:
    - export PROMPT_COMMAND='{ msg=$(history 1 | { read x y