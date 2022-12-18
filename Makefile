.PHONY: clean
clean:
	find . -name '*~' -exec rm -f {} +
	find . -name '.#*' -exec rm -f {} +
