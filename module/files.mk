
# this .mk file current dir
LOCAL_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

RTL_SEARCH_DIRS := core system system/uart16550

RTL_SYN_FILES += $(filter %.v %.sv %.vh, %.svh,              \
                      $(foreach dir, $(RTL_SEARCH_DIRS),     \
                          $(wildcard $(LOCAL_DIR)/$(dir)/*)) \
                  )
