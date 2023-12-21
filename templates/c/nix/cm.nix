{pkgs}:
pkgs.writeScriptBin "cm" ''
  BUILD_COMMAND="cmake -S . -B build && cmake --build build"
  RUN_COMMAND="./build/target"

  if [ $# -eq 0 ]; then
      echo "Usage: $0 [build|run]"
      exit 1
  fi

  # Process user arguments
  for arg in "$@"; do
      case "$arg" in
      build)
          echo "$BUILD_COMMAND"
          eval "$BUILD_COMMAND"
          ;;
      run)
          echo "$BUILD_COMMAND && $RUN_COMMAND"
          eval "$BUILD_COMMAND"
          eval "$RUN_COMMAND"
          ;;
      *)
          echo "Unknown option: $arg. Use 'build', 'run'."
          exit 1
          ;;
      esac
  done
''
