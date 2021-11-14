#directory stuffs
SHELL = /bin/bash
TOP := $(shell pwd)
PYTHON=python3.6

#project stuffs
MAIN_PRJ ?= hello
PRJ_DIR ?= $(TOP)/upload

#board stuffs
BRD_IP?=192.168.2.99
BRD_DIR?=/home/xilinx/file
BRD_USR?=xilinx

.PHONY: files all

help:
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo "           FPGA actions template makefile helper           "
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo ""
	@echo " [HELP] 'make' shows this helper"
	@echo ""
	@echo " [HELP] 'make print_config'  print project current config generation"
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo " [INFO] 'make all'  clone and run files"
	@echo ""
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo " [INFO] 'make python' create python file"
	@echo " [INFO] 'make bit' create bit file"
	@echo " [INFO] 'make files' create both file"
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo "                     Clone files                             "
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo "[INFO] 'make clone_py' clone python file in the 'file' folder"
	@echo "[INFO] 'make clone_bit' clone python file in the 'file' folder"
	@echo "[INFO] 'make clone' clone all files in the 'file' folder"
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo "                     Clean utilities                             "
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo "[INFO] 'make clean' cleans everything in the 'upload' folder"
	@echo "[INFO] 'make cleanboard' cleans everything in the 'file' folder on board"
	@echo ""
	@echo ""
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo ""
	@echo "            End of FPGA actions template makefile helper       "
	@echo ""
	@echo "*****************************************************************"
	@echo "*****************************************************************"
	@echo "*****************************************************************"

############################################################################################################
################################### CREATE FILES ###########################################################
############################################################################################################

python:
#create file python
	touch $(PRJ_DIR)/$(MAIN_PRJ).py

bit:
#create file bit
	touch $(PRJ_DIR)/$(MAIN_PRJ).bit

files: python bit


############################################################################################################
############################################## ACTIONS #####################################################
############################################################################################################

clone_py:
	rsync -avz $(PRJ_DIR)/$(MAIN_PRJ).py $(BRD_USR)@$(BRD_IP):$(BRD_DIR)
clone_bit:
	rsync -avz $(PRJ_DIR)/$(MAIN_PRJ).bit $(BRD_USR)@$(BRD_IP):$(BRD_DIR)

clone: clone_py clone_bit

run_py:
	ssh $(BRD_USR)@$(BRD_IP) -c $(PYTHON) $(BRD_DIR)/$(MAIN_PRJ).py

run_bit:
	ssh $(BRD_USR)@$(BRD_IP) -c $(BRD_DIR)/$(MAIN_PRJ).bit

#return:
##################
#####TO DO########
##################

all: clone_py clone_bit run_py  


############################################################################################################
############################################ CLEAN #########################################################
############################################################################################################
cleanall:
	rm $(PRJ_DIR)/*.py
	rm $(PRJ_DIR)/*.bit

cleanboard:
#	ssh $(BRD_USR)@$(BRD_IP) -c rm -rf $(BRD_DIR)/*
	ssh $(BRD_USR)@$(BRD_IP) 'rm $(BRD_DIR)/*.py'
	ssh $(BRD_USR)@$(BRD_IP) 'rm $(BRD_DIR)/*.bit'
##################
#####TO DO########
##################
