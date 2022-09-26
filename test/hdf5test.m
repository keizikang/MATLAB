system('rm example_hdf5.h5');

jan_data = ones(10, 31);
feb_data = ones(10, 28);
mar_data = ones(10, 31);

% line01
[row, col] = size(jan_data);
h5create('example_hdf5.h5', '/line01/jan', [row, col])
h5write('example_hdf5.h5', '/line01/jan', jan_data)

[row, col] = size(feb_data);
h5create('example_hdf5.h5','/line01/feb', [row, col])
h5write('example_hdf5.h5', '/line01/feb', feb_data)

[row, col] = size(mar_data);
h5create('example_hdf5.h5','/line01/mar', [row, col])
h5write('example_hdf5.h5', '/line01/mar', mar_data)

% line02
[row, col] = size(jan_data);
h5create('example_hdf5.h5','/line02/jan', [row, col])
h5write('example_hdf5.h5', '/line02/jan', jan_data)

[row, col] = size(feb_data);
h5create('example_hdf5.h5','/line02/feb', [row, col])
h5write('example_hdf5.h5', '/line02/feb', feb_data)

[row, col] = size(mar_data);
h5create('example_hdf5.h5','/line02/mar', [row, col])
h5write('example_hdf5.h5', '/line02/mar', mar_data)

h5disp('example_hdf5.h5')