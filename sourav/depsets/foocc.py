import sys

if __name__ == "__main__":
  assert len(sys.argv) >= 1
  output = open(sys.argv[1], "wt")
  for path in sys.argv[2:]:
    input = open(path, "rt")
    #print(input)
    output.write(input.read())