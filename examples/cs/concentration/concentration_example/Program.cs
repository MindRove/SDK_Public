using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using System;
using brainflow;

using Accord.Math;

namespace brainflow_cs_test
{
    static class Program
    {

        static BoardShim board_shim = null;
        static MLModel concentration = null;
        static int sampling_rate = 250;
        static int[] eeg_channels = null;
        static int counter_idx = 0;

        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] args)
        {
            try
            {
                BoardShim.enable_dev_board_logger();

                BrainFlowInputParams input_params = new BrainFlowInputParams();
                int board_id = (int)BoardIds.MINDROVE_WIFI_BOARD;//= parse_args(args, input_params);

                board_shim = new BoardShim(board_id, input_params);
                board_shim.prepare_session();

                board_shim.start_stream(); // use this for default options
                                           //board_shim.start_stream(450000, "file://file_stream.csv:w");

                board_shim.config_board(BoardShim.MindroveWifiConfigMode.EEG_MODE);
                BrainFlowModelParams concentration_params = new BrainFlowModelParams((int)BrainFlowMetrics.CONCENTRATION, (int)BrainFlowClassifiers.REGRESSION);
                concentration = new MLModel(concentration_params);
                concentration.prepare();

                sampling_rate = BoardShim.get_sampling_rate(board_id);
                eeg_channels = BoardShim.get_eeg_channels(board_id);
                counter_idx = BoardShim.get_package_num_channel(board_id);

            }
            catch (BrainFlowException ex)
            {
                Console.WriteLine(ex);

            }
            while (Update() >= 0)
            {

            }

            if (board_shim != null)
            {
                try
                {
                    board_shim.release_session();
                    concentration.release();
                }
                catch (BrainFlowException e)
                {
                    Console.WriteLine(e);
                }
                Console.WriteLine("Brainflow streaming was stopped");
            }
            Console.ReadLine();
        }

        static int Update()
        {
            if ((board_shim == null) || (concentration == null))
            {
                Console.ReadLine();
                return -1;
            }
            int number_of_data_points = sampling_rate * 4; // 4 second window is recommended for concentration and relaxation calculations


            double[,] data = board_shim.get_current_board_data(number_of_data_points);
            
            if (data.GetRow(0).Length < number_of_data_points)
            {
                // wait for more data
                return 0;
            }
            
            // prepare feature vector
            Tuple<double[], double[]> bands = DataFilter.get_avg_band_powers(data, eeg_channels, sampling_rate, true);
            double[] feature_vector = bands.Item1.Concatenate(bands.Item2);
            // calc and print concetration level
            // for synthetic board this value should be close to 1, because of sin waves ampls and freqs
            Console.WriteLine("Concentration: " + concentration.predict(feature_vector));
            
            
            return 0;
            
        }
    }
}
