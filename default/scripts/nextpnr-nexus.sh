cd nextpnr
build_gui="OFF"
if [ ${ARCH} == 'linux-x64' ] || [ ${ARCH} == 'windows-x64' ] || [ ${ARCH} == 'darwin-x64' ]; then
      build_gui="ON"
fi
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
      -DPython3_INCLUDE_DIR=${BUILD_DIR}/python3${INSTALL_PREFIX}/include/python3.8 \
      -DPython3_LIBRARY=${BUILD_DIR}/python3${INSTALL_PREFIX}/lib/libpython3.8${SHARED_EXT} \
      -DARCH=nexus \
      -DNEXUS_CHIPDB=${BUILD_DIR}/prjoxide-bba/nexus/chipdb \
      -DBUILD_GUI=${build_gui} -DUSE_IPO=OFF . -DBBA_IMPORT=${BUILD_DIR}/nextpnr-bba/nextpnr/bba/bba-export.cmake
make DESTDIR=${OUTPUT_DIR} -j${NPROC} install
${STRIP} ${OUTPUT_DIR}${INSTALL_PREFIX}/bin/nextpnr-nexus${EXE}
