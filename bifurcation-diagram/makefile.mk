asset_1  := bif-diag-N12=1280-comparator=minima-order=1-start_time=900.pdf
script_1 := plot-bif-diag.py
data_1   := $(exp)/_output-cache/bif-data-N12=1280-minima-order=1-start_time=900.npz

asset_list += $(exp)/_assets/$(asset_1)

$(exp) : $(BUILD_DIR)/$(asset_1)

$(BUILD_DIR)/$(asset_1) : $(exp)/_assets/$(asset_1)

$(exp)/_assets/$(asset_1) : $(exp)/$(script_1)
	cd ${<D} && \
	python ${<F} 1280 --comparator=minima --order=1 --start-time=900

$(exp)/$(script_1) : $(data_1) $(exp)/lib_bifdiag.py


asset_2 := time-series-and-phase-portraits-together.pdf
script_2 := plot-time-series-and-phase-portraits-together.py
data_2   := $(wildcard $(exp)/_output-cache/N12=1280/*/detonation-velocity.npz)

$(exp) : $(BUILD_DIR)/$(asset_2)

$(BUILD_DIR)/$(asset_2) : $(exp)/_assets/$(asset_2)

$(exp)/_assets/$(asset_2) : $(exp)/$(script_2)
	cd ${<D} && python ${<F}

$(exp)/$(script_2) : $(data_2) $(exp)/lib_timeseries.py


script := plot-time-series-and-phase-portrait.py

$(exp)/$(script) : $(exp)/lib_timeseries.py

asset_2 := analysis-theta=0.950.pdf
asset_3 := analysis-theta=1.000.pdf
asset_4 := analysis-theta=1.004.pdf
asset_5 := analysis-theta=1.055.pdf
asset_6 := analysis-theta=1.065.pdf
asset_7 := analysis-theta=1.089.pdf
data_2 := $(exp)/_output-cache/N12=1280/theta=0.950/detonation-velocity.npz
data_3 := $(exp)/_output-cache/N12=1280/theta=1.000/detonation-velocity.npz
data_4 := $(exp)/_output-cache/N12=1280/theta=1.004/detonation-velocity.npz
data_5 := $(exp)/_output-cache/N12=1280/theta=1.055/detonation-velocity.npz
data_6 := $(exp)/_output-cache/N12=1280/theta=1.065/detonation-velocity.npz
data_7 := $(exp)/_output-cache/N12=1280/theta=1.089/detonation-velocity.npz

asset_list += $(exp)/_assets/$(asset_2)

$(exp) : $(BUILD_DIR)/$(asset_2)

$(BUILD_DIR)/$(asset_2) : $(exp)/_assets/$(asset_2)

$(exp)/_assets/$(asset_2) : $(exp)/$(script)
	cd ${<D} && python ${<F} 1280 0.950

$(exp)/$(script) : $(data_2)

asset_list += $(exp)/_assets/$(asset_3)

$(exp) : $(BUILD_DIR)/$(asset_3)

$(BUILD_DIR)/$(asset_3) : $(exp)/_assets/$(asset_3)

$(exp)/_assets/$(asset_3) : $(exp)/$(script)
	cd ${<D} && python ${<F} 1280 1.000

$(exp)/$(script) : $(data_3)

asset_list += $(exp)/_assets/$(asset_4)

$(exp) : $(BUILD_DIR)/$(asset_4)

$(BUILD_DIR)/$(asset_4) : $(exp)/_assets/$(asset_4)

$(exp)/_assets/$(asset_4) : $(exp)/$(script)
	cd ${<D} && python ${<F} 1280 1.004

$(exp)/$(script) : $(data_4)

asset_list += $(exp)/_assets/$(asset_5)

$(exp) : $(BUILD_DIR)/$(asset_5)

$(BUILD_DIR)/$(asset_5) : $(exp)/_assets/$(asset_5)

$(exp)/_assets/$(asset_5) : $(exp)/$(script)
	cd ${<D} && python ${<F} 1280 1.055 --with-inset

$(exp)/$(script) : $(data_5)

asset_list += $(exp)/_assets/$(asset_6)

$(exp) : $(BUILD_DIR)/$(asset_6)

$(BUILD_DIR)/$(asset_6) : $(exp)/_assets/$(asset_6)

$(exp)/_assets/$(asset_6) : $(exp)/$(script)
	cd ${<D} && python ${<F} 1280 1.065 --with-inset

$(exp)/$(script) : $(data_6)

asset_list += $(exp)/_assets/$(asset_7)

$(exp) : $(BUILD_DIR)/$(asset_7)

$(BUILD_DIR)/$(asset_7) : $(exp)/_assets/$(asset_7)

$(exp)/_assets/$(asset_7) : $(exp)/$(script)
	cd ${<D} && python ${<F} 1280 1.089 --with-inset

$(exp)/$(script) : $(data_7)

$(data_2) $(data_3) $(data_4) $(data_5) $(data_6) $(data_7) : $(exp)/time-series.tar.gz
	# Extract archive.
	tar xf $< -C $(<D)
	# Update timestamps of all extracted data to avoid multiple extractions.
	find $(<D)/_output-cache/N12=1280/ -type f -exec touch {} \;

$(exp)/time-series.tar.gz:
	# Download time-series.tar.gz from Zenodo.org because its ~500 MB.
	curl -L \
		https://zenodo.org/record/1286283/files/time-series-fickett-model.tar.gz?download=1 \
		-o $@
