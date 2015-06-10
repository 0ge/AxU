
# -------------------------------------------------------#
# ------------------- Project settings ------------------#
# -------------------------------------------------------#

# Target filename
TARGET = main

# Hardware
UPLOADER = avrdude
UPLOADER_FLAGS = -B16
MCU = ___VARIABLE_MCU___
PROGRAMMER = ___VARIABLE_PROGRAMMER___
F_CPU = ___VARIABLE_F_CPU___


# -------------------------------------------------------#
# -------------------- Files & paths --------------------#
# -------------------------------------------------------#

# Folders
PATHS = src
PATHB = build
PATHI = inc
PATHT = test
PATHU = unity
PATHO = $(PATHB)/obj
PATHE = $(PATHB)/bin
PATHET = $(PATHB)/test

# Source files
SRCU = $(PATHU)/unity.c
SRCS = $(wildcard $(PATHS)/*.c)
SRCT = $(wildcard $(PATHT)/*.c)
SRC = $(SRCS)

# Includes
INC = $(wildcard $(PATHI)/*.h)

# Object files
OBJU = $(patsubst $(PATHU)%.c,$(PATHO)%.o,$(SRCU))
OBJT = $(patsubst $(PATHT)%.c,$(PATHO)%.o,$(SRCT))
OBJS = $(patsubst $(PATHS)%.c,$(PATHO)%.o,$(SRCS))
OBJ = $(OBJS)


# -------------------------------------------------------#
# ---------------------- OS config ----------------------#
# -------------------------------------------------------#

CLEANUP = rm -f
MKDIR = mkdir -p


# -------------------------------------------------------#
# ------------------ Compiler settings ------------------#
# -------------------------------------------------------#

# Compiler
CCD = avr-gcc

# C standard
CSTANDARDD = -std=gnu99

# Optimize level (s = size)
OPTD = s

# Warning level
WARND = all

# Combine flags
CFLAGSD = -c
CFLAGSD += -I$(PATHI)
CFLAGSD += -W$(WARN)
CFLAGSD += -DF_CPU=$(F_CPU)
CFLAGSD += -O$(OPT)
CFLAGSD += -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums
CFLAGSD += -W$(WARN) -Wstrict-prototypes
CFLAGSD += $(CSTANDARD)
CFLAGSD += -mmcu=$(MCU)
CFLAGSD += -gstabs
CFLAGSD += -gstrict-dwarf
CFLAGSD += -c

# Linker
LND = avr-gcc -o
LFLAGSD = -Wall -I. -lm


# -------------------------------------------------------#
# --------------------- Test config ---------------------#
# -------------------------------------------------------#

# Compiler & linker
CCT = gcc
LNT = gcc -o

# Compiler flags
CFLAGST = -Wall
CFLAGST += -c
CFLAGST += -I$(PATHU)
CFLAGST += -DTEST



# -------------------------------------------------------#
# ------------------- Target selection ------------------#
# -------------------------------------------------------#

ifeq ($(MAKECMDGOALS),test)

CC=$(CCT)
CFLAGS=$(CFLAGST)

LN=$(LNT)
LFLAGS=$(LFLAGST)

SRC += $(SRCT) $(SRCU)
OBJ += $(OBJT) $(OBJU)

else

CC=$(CCD)
CFLAGS=$(CFLAGSD)

LN=$(LND)
LFLAGS=$(LFLAGSD)

endif

# -------------------------------------------------------#
# ------------------------ Misc. ------------------------#
# -------------------------------------------------------#

# Messages
START_MSG = "Make started."
END_MSG = "Make finished."
DIV = "--------------------------"

# -------------------------------------------------------#
# ------------------------ Rules ------------------------#
# -------------------------------------------------------#

all: start clean build end

test: start test_exec end

start:
	@echo $(START_MSG)
	@echo "Source files:" $(SRC)
	@echo "Object files:" $(OBJ)
	@echo "Includes:" $(INC)
	@echo "Compiler:" $(CC)
	@echo "Linker:" $(LN)
	@echo $(DIV)

end:
	@echo $(DIV)
	@echo $(END_MSG)

clean:
	$(CLEANUP) $(PATHO)/*.o
	$(CLEANUP) $(PATHE)/$(TARGET)
	$(CLEANUP) $(PATHE)/$(TARGET).hex
	$(CLEANUP) $(PATHET)/*

test_exec: mkdir $(OBJ)
	$(LN) $(PATHET)/$(TEST).out $(LFLAGS) $(OBJ)
	@echo "Link" $@ "complete!"

hex: link
	rm -f $(PATHE)/$(TARGET).hex
	avr-objcopy -j .text -j .data -O ihex $(PATHE)/$(TARGET) $(PATHE)/$(TARGET).hex
	avr-size --format=avr --mcu=$(MCU) $(PATHE)/$(TARGET)

build: link

flash: hex
	$(UPLOADER) -c $(PROGRAMMER) -p $(MCU) $(UPLOADER_FLAGS) -U flash:w:$(PATHE)/$(TARGET).hex:i

link: mkdir $(OBJ)
	$(LN) $(PATHE)/$(TARGET) $(LFLAGS) $(OBJ)
	@echo "Link complete!"

mkdir:
	$(MKDIR) $(PATHB)
	$(MKDIR) $(PATHO)
	$(MKDIR) $(PATHE)
	$(MKDIR) $(PATHET)

$(PATHO)/%.o:: $(PATHS)/%.c
	$(CC) $(CFLAGS) $< -o $@
	@echo "Compiled "$<"."

$(PATHO)/%.o:: $(PATHT)/%.c
	$(CC) $(CFLAGS) $< -o $@
	@echo "Compiled "$<"."

$(PATHO)/%.o:: $(PATHU)/%.c
	$(CC) $(CFLAGS) $< -o $@
	@echo "Compiled "$<"."
