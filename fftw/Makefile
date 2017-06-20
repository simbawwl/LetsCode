TARGET   = test
MPIF90      = gfortran
CFLAGS  =  -g 
OPT     = -O3
#LIBS    = -L./lib -lfftw -lfftw3f_threads -lfftw3f
LIBS    =  -lfftw3f_threads -lfftw3f


BIN_PTH = .
SRC_PTH = .
SOURCE  = $(SRC_PTH)/test1.f90 


OBJ	= $(patsubst %.f,%.o,$(patsubst %.f90,%.o,$(SOURCE)))


## Default rule executed
all: $(TARGET)
	@true
%.o: %.f90
	@echo
	@echo "=> Compiling $<"
	@$(MPIF90) $(CFLAGS) $(OPT) $(DEFINES) -c $^ -o $@ 
%.o: %.f
	@echo
	@echo "=> Compiling $<"
	@$(MPIF90) $(CFLAGS) $(OPT) $(DEFINES) -c $^ -o $@ 

$(TARGET): $(OBJ) 
	@echo
	@echo "=> Linking the target $@"
	@$(MPIF90) $(CFLAGS) $(OPT) -o $(BIN_PTH)/$@ $^ $(LIBS)
	@echo '=> Link done'
#	@echo $(OBJ) 




# the rule to clean
clean:
	@-rm *.o
	@echo "=> Clean done"

