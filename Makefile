#directory stuffs
SHELL = /bin/bash
TOP := $(shell pwd)
PYTHON=python3.6

#project stuffs
MAIN_PRJ ?= drambenchmark
PRJ_DIR ?= $(TOP)/build

#board stuffs
BRD_IP?=192.168.2.99
BRD_DIR?=/home/xilinx/file/
BRD_USR?=xilinx

.PHONY:help clone run_on_board return python bit files all cleanall cleanboard

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
	@echo " [INFO] 'make all' prepare everything"
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
	@echo "                     Clean utilities                             "
	@echo ""
	@echo "*****************************************************************"
	@echo ""
	@echo "[INFO] 'make clean' cleans everything in the build folder"
	@echo "[INFO] 'make cleanboard' cleans everything in the build folder on board"
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
	@make helpactions
	@make helpconfig

########################################################################################################

##########################################
############## ACTIONS ###################
##########################################


#più utile nel make perché nel caso posso posso forzare l'action
set_runner:


clone:
#update time and date file
#	touch $(MAIN_PRJ).py
#copy file on board
	rsync -avz $(MAIN_PRJ).py $(BRD_USR)@$(BRD_IP):$(BRD_DIR)
#remove from local repository
#	rm $(MAIN_PRJ).py

run_on_board:
#run .py file
	ssh $(BRD_USR)@$(BRD_IP) -c $(PYTHON) $(BRD_DIR)/$(MAIN_PRJ).py
#run .bit file
	ssh $(BRD_USR)@$(BRD_IP) -c $(BRD_DIR)/$(MAIN_PRJ).bit

return:
##################
#####TO DO########
##################

#####################################################################################################

##############################################
############## CREATE FILE ###################
##############################################

python:
#create file python

bit:
#create file bit
	touch $(MAIN_PRJ).bit

files: python bit

all: python bit clone run_on_board return

#####################################################################################################

##########################################
################ CLEAN ###################
##########################################
cleanall:
	rm -rf $(BUILD_DIR)/*

cleanboard:
	ssh $(BRD_USR)@$(BRD_IP) -c rm -rf $(BRD_DIR)/*
##################
#####TO DO########
##################
