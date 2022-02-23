% Read data from board, filter and arrange them for display
function y = read_data(board_shim, board_id)
    filter_order = 2;
    band_width = 12.5;
    sampling_rate = BoardShim.get_sampling_rate(board_id);
    
    cutoff = 5;
    data = board_shim.get_current_board_data(2*sampling_rate + cutoff);
    eeg_channels = BoardShim.get_eeg_channels(board_id);
    eeg_data = data(eeg_channels, :)';
    
    for i = 0:1:length(eeg_channels) - 1
         eeg_data(:, i+1) = DataFilter.perform_highpass(eeg_data(:, i+1), sampling_rate, 0.5, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 50, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 100, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 150, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 200, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
         eeg_data(:, i+1) = DataFilter.perform_highpass(eeg_data(:, i+1), sampling_rate, 0.5, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 50, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 100, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 150, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = DataFilter.perform_bandstop(eeg_data(:, i+1), sampling_rate, 200, band_width, filter_order, int32(FilterTypes.BUTTERWORTH), 0);
%         eeg_data(:, i+1) = 10*((eeg_data(:, i+1) - mean(eeg_data(:, i+1)))/(max(eeg_data(:, i+1)) - min(eeg_data(:, i+1)))) + i;
    end
    y = eeg_data(cutoff + 1:end, :);
end
