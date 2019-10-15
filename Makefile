HOSTNAME := $(shell hostname -s)
DATE := $(shell date +%F)

BASENAME := $(HOSTNAME)/$(DATE)

details := lscpu cpuinfo dmi-modalias cpu-modalias uname-r uname-v uname-m detect-virt
benchmarks := cpu-st cpu-mt-2 cpu-mt-4 cpu-mt-8

.phony: $(BASENAME)
$(BASENAME): $(foreach x,$(details) $(benchmarks),$(BASENAME)/$x)

%/lscpu:
	mkdir -p "$*"
	lscpu > "$@"

%/cpuinfo:
	mkdir -p "$*"
	cp /proc/cpuinfo "$@"

%/dmi-modalias:
	mkdir -p "$*"
	cp /sys/class/dmi/id/modalias "$@"

%/cpu-modalias:
	mkdir -p "$*"
	cp /sys/devices/system/cpu/modalias "$@"

%/uname-r:
	mkdir -p "$*"
	uname -r > "$@"

%/uname-v:
	mkdir -p "$*"
	uname -v > "$@"

%/uname-m:
	mkdir -p "$*"
	uname -m > "$@"

%/detect-virt:
	mkdir -p "$*"
	-systemd-detect-virt > "$@"

%/cpu-st:
	mkdir -p "$*"
	sysbench cpu run > "$@"

%/cpu-mt-2:
	mkdir -p "$*"
	sysbench cpu --threads=2 run > "$@"

%/cpu-mt-4:
	mkdir -p "$*"
	sysbench cpu --threads=4 run > "$@"

%/cpu-mt-8:
	mkdir -p "$*"
	sysbench cpu --threads=8 run > "$@"
