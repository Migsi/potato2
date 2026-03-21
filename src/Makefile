.PHONY: clean all

CFILES                :=    \
     main.c                 \
     login2.c               \
     userlist.c             \
     sock.c                 \
     func.c                 \
     runr.c                 \
     http_server.c          \
     console_server.c       \
     session.c

HEADERS                :=   \
    console_server.h        \
    func.h                  \
    http.h                  \
    logger.h                \
    runr.h                  \
    session.h               \
    sock.h                  \
    user.h                  \
    userlist.h

# OPENSSL Version to link 32bit binary against
OPENSSL_VERSION        := 3.0.13

# Turn off warnings that report bad code style :-)
CC_FLAGS_WARNINGS     :=                 \
    -Wno-deprecated-declarations         \
    -Wno-implicit-function-declaration   \
    -Wno-unused-result                   \
    -Wno-format-truncation

# Allow code execution on stack
# disable stack canaries
# Do not use hardened libc functions
# no position independent code
CC_SECURITY_FLAGS    :=     \
    -z execstack            \
    -fno-stack-protector    \
    -D_FORTIFY_SOURCE=0     \
    -no-pie

CCOPTS_64BIT_STACK_EXEC := -g -Og $(CC_FLAGS_WARNINGS) $(CC_SECURITY_FLAGS)
CCOPTS_32BIT_STACK_EXEC := -m32 -Iopenssl-${OPENSSL_VERSION}/include $(CCOPTS_64BIT_STACK_EXEC)

# link openssl crypto lib 
LINKER_FLAGS            :=    -lcrypto
LINKER_FLAGS_32         :=    -Lopenssl-${OPENSSL_VERSION} $(LINKER_FLAGS)

all: potato potato32

potato: $(CFILES) $(HEADERS)
	gcc $(CCOPTS_64BIT_STACK_EXEC) $(CFILES) $(LINKER_FLAGS) -o $@

potato32: openssl-${OPENSSL_VERSION}/libcrypto.a $(CFILES) $(HEADERS)
	gcc $(CCOPTS_32BIT_STACK_EXEC) $(CFILES) $(LINKER_FLAGS_32) -o $@

# build the open ssl crypto lib as static libary w/o loading shared objects    
# make clean before make is required due to
# https://github.com/openssl/openssl/issues/17534#issuecomment-1015269592
openssl-${OPENSSL_VERSION}/libcrypto.a: openssl-${OPENSSL_VERSION}.tar.gz
	tar -xzf openssl-${OPENSSL_VERSION}.tar.gz && \
	cd openssl-${OPENSSL_VERSION} && \
	./Configure -m32 linux-generic32 no-shared && \
	make clean && \
	make build_libs -sj && \
	cd ..

openssl-${OPENSSL_VERSION}.tar.gz:
	wget https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz

clean:
	rm -f potato potato32

clobber:
	rm -rf potato potato32 openssl-${OPENSSL_VERSION}.tar.gz openssl-${OPENSSL_VERSION}
