PROJECT_ROOT="/src"

if [[ ! -d "$PROJECT_ROOT" ]]; then
  echo "You didn't mount the project volume."
  return 1
fi

cd "$PROJECT_ROOT"

cat <<EOF
To run the OS:

In one terminal, type gdb to start GDB.
In a second terminal, type make qemu-nox-gdb
EOF

