.PHONY: clean
all: gen-all

clean:
	find . -name '*~' -exec rm -f {} +
	find . -name '.#*' -exec rm -f {} +

.PHONY: gen-all lint
gen-all:
	CURRENT_ENV=$(CURRENT_ENV) ./deploy-utils.sh gen-all
lint:
	CURRENT_ENV=$(CURRENT_ENV) ./deploy-utils.sh lint

check: gen-all lint
