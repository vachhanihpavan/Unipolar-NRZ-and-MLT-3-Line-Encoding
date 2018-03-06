% Taking Inputs in input_stream array
n = input('Enter length of bit stream : ');
input_stream = input('Enter the bit stream in single quotes  : ');

% User defined parameters
bit_rate_uni = 0; % Unipolar NRZ
bit_rate_mlt = 0; % MLT 3

% Default Parameters
bit_rate = 0;
baud_rate = 0;
band_width = 0;

% Printing options
choice = input('\nChoose a parameter to modify:\n1. Bit Rate\n2. Baud Rate\n3. Bandwidth\nEnter your choice : ');
if choice==1
	bit_rate = input('\nEnter the bit rate : ');
	bit_rate_uni = bit_rate;
	bit_rate_mlt = bit_rate;
elseif choice==2
	baud_rate = input('\nEnter the baud rate : ');
	bit_rate_uni = 2*baud_rate;
	bit_rate_mlt = 2*baud_rate;
elseif choice==3
	band_width = input('\nEnter the bandwidth rate : ');
	bit_rate_uni = 2*band_width;
	bit_rate_mlt = 3*band_width;
else
	fprintf('\nInvalid input... Chosing default values\n');
end

% Initialisation
sample_rate = 10000;                    %step value
x_line = zeros(1, n*sample_rate +2);    % Makes all values in matrix as 0
uni = zeros(1, n*sample_rate +2);       % Makes all values in matrix as 0
mlt = zeros(1, n*sample_rate +2);       % Makes all values in matrix as 0

% X axis values for default graphs
for i = 0:(n*sample_rate)
	x_line(i+2) = i/sample_rate;        % X-axis values are generated according to input length
end

% Y axis values for Unipolar NRZ
uni(1) = 0;                             % Initialise the graph with 0
uni(n*sample_rate +2) = 0;

% Code to convert input stream to UNRZ
for i = 0:(n*sample_rate -1)
		if input_stream(floor(i/sample_rate) +1) - '0' == 0
			uni(i+2) = 0;
		else
			uni(i+2) = 1;
		end
end

% Y axis values for MLT-3
mlt(1) = 0;                             % Initialise the graph with 0
mlt(n*sample_rate +2) = 0;
var = 1;                                % Variable remembers the previous state was 1 or -1
% Code for initial input bit 
if (input_stream(1) == '1')
    mlt(1) = 1;
else
    mlt(1) = 0;
end

% Code to convert input stream to MLT-3
for i = 1:(n*sample_rate -1)
		if input_stream(floor(i/sample_rate) +1) - '0' == 0
			mlt(i+1) = mlt(i);
        else
            if(mod(i,sample_rate)==0)
                if (var == 0)
                    mlt(i+1) = mlt(i) + 1;
                    if mlt(i+1) > 1
                        var = 1;
                        mlt(i+1) = 0;
                    end
                else
                    mlt(i+1) = mlt(i) - 1;
                    if mlt(i+1) < -1
                        var = 0;
                        mlt(i+1) = 0;
                    end
                end
            else
                mlt(i+1) = mlt(i);
            end
		end
end


% Default Graphs plotting

% Plotting Unipolar NRZ --------------------------------------------
subplot(2, 2, 1)
plot(x_line, uni)           % Plot function
axis([-0.1, n+0.7*n, -1.2, 1.7])
xlabel('Time(sec)')         % Labelling
ylabel('Amplitude')
title('Unipolar NRZ')

% Printing the parameter details
text(n+0.2, 1.0, 'r = 0.5')
text(n+0.2, 0.5, 'Bit Rate = 1.0 bps')
text(n+0.2, 0.0, 'Baud Rate = 1.0 baud')
text(n+0.2, -0.5, 'Bandwidth = 1.0 bps')

for i = 0:(n-1)
	text(i+0.5, 1.2, input_stream(i+1))
end


subplot(2, 2, 3)
plot(x_line, mlt)               % Plot function
axis([-0.1, n+0.7*n, -1.2, 1.7])
xlabel('Time (sec)')            % Labelling
ylabel('Amplitude')
title('MLT-3(Default)')

% Printing the parameter details
text(n+0.2, 1.0, 'r = 1.0')
text(n+0.2, 0.5, 'Bit Rate = 1.0 bps')
text(n+0.2, 0.0, 'Baud Rate = 0.5 baud')
text(n+0.2, -0.5, 'Bandwidth = 0.333 bps')

for i = 0:(n-1)
	text(i+0.5, 1.2, input_stream(i+1))
end

% User-defined graphs

% Plotting Unipolar NRZ

% X axis values for user-defined graphs
for i = 0:(n*sample_rate)
	x_line(i+2) = i/sample_rate/bit_rate_uni;
end

subplot(2, 2, 2)
plot(x_line, uni)           % Plot function
axis([-0.1, n/bit_rate_uni+0.7*n/bit_rate_uni, -1.2, 1.7])
xlabel('Time (sec)')        % Labelling
ylabel('Amplitude')
title('Unipolar NRZ (Modified)')

% Printing the parameter details
text(n/bit_rate_uni+0.2/bit_rate_uni, 1.0, 'r = 1')
text(n/bit_rate_uni+0.2/bit_rate_uni, 0.5, strcat(strcat('Bit Rate = ', num2str(bit_rate_uni)), ' bps'))
text(n/bit_rate_uni+0.2/bit_rate_uni, 0.0, strcat(strcat('Baud Rate = ', num2str(2*bit_rate_uni)), ' baud'))
text(n/bit_rate_uni+0.2/bit_rate_uni, -0.5, strcat(strcat('Bandwidth = ', num2str(2*bit_rate_uni)), ' bps'))

for i = 0:(n-1)
	text(i/bit_rate_uni+0.3/bit_rate_uni, 1.2, input_stream(i+1))
end

subplot(2, 2, 4)
plot(x_line, mlt)           % Plot function
axis([-0.1, n/bit_rate_uni+0.7*n/bit_rate_uni, -1.2, 1.7])
xlabel('Time (sec)')            % Labelling
ylabel('Amplitude')
title('MLT-3 (Modified)')

% Printing the parameter details
text(n/bit_rate_uni+0.2/bit_rate_uni, 1.0, 'r = 1')
text(n/bit_rate_uni+0.2/bit_rate_uni, 0.5, strcat(strcat('Bit Rate = ', num2str(bit_rate_uni)), ' bps'))
text(n/bit_rate_uni+0.2/bit_rate_uni, 0.0, strcat(strcat('Baud Rate = ', num2str(2*bit_rate_uni)), ' baud'))
text(n/bit_rate_uni+0.2/bit_rate_uni, -0.5, strcat(strcat('Bandwidth = ', num2str(3*bit_rate_uni)), ' bps'))

for i = 0:(n-1)
	text(i/bit_rate_uni+0.3/bit_rate_uni, 1.2, input_stream(i+1))
end
