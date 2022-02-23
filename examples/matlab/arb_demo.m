global user_break
user_break = false;

% Initialize board
BoardShim.set_log_file('brainflow.log');
BoardShim.enable_dev_board_logger();
params = BrainFlowInputParams();
board_id = int32(BoardIDs.MINDROVE_WIFI_BOARD);
board_shim = BoardShim(board_id, params);
board_shim.prepare_session();
board_shim.start_stream(45000, '');

% Initialize figure, read and display initial data
figure('CloseRequestFcn',@my_closereq)
pause(3);
y = read_data(board_shim, board_id);
x = linspace(1, 1000, 1000);
x = repmat(x, size(y, 2), 1)';
myplot = plot(x,y,'XDataSource','x','YDataSource','y', 'LineWidth', 1.5);
axis off;
set(gcf,'InvertHardCopy','off','Color','black');

% Read and display data in a loop
while user_break == false
    pause(0.01);
    y = read_data(board_shim, board_id);
    refreshdata;
end

% Cleanup after the user closed the figure
close all force;
board_shim.stop_stream();
board_shim.release_session();