% Given a stream of data bits as input, you are required to produce 
% a Unipolar  NRZ  Signal.  Further  convert  it  into  MLT-3  scheme.  
% Record  your observations and obtain the differences between the
% two schemes in terms of bit rate, baud rate, bandwidth, value of r. 
% Also, you are required to vary the above mentioned parameters and 
% record the results (for eg.increase the bit rate and observe how the
% waveform changes).Plot graphs to substantiate your recorded observations.	

n = input('Enter number of bits : ');
stream_bits = input('Enter the bits (within single quotes ('''')) : ');

% User parameters
bit_rate1 = 0; % Unipolar NRZ
bit_rate2 = 0; % MLT 3

bit_rate = 0;
baud_rate = 0;
band_width = 0;

ch = input('\nChoose a parameter\n1. Bit Rate\n2. Baud Rate\n3. Bandwidth\nEnter your choice : ');
if ch==1
	bit_rate = input('\nEnter the bit rate : ');
	bit_rate1 = bit_rate;
	bit_rate2 = bit_rate;
elseif ch==2
	baud_rate = input('\nEnter the baud rate : ');
	bit_rate1 = baud_rate;
	bit_rate2 = 0.75*baud_rate;
elseif ch==3
	band_width = input('\nEnter the bandwidth rate : ');
	bit_rate1 = band_width;
	bit_rate2 = 3*band_width;
else
	fprintf('\nInvalid input... Chosing default values\n');
end

fs = 10000; %step value
x = zeros(1, n*fs +2);
y1 = zeros(1, n*fs +2);
y2 = zeros(1, n*fs +2);

% X values
for i = 0:(n*fs)
	x(i+2) = i/fs;
end

% Y1 values
y1(1) = 0;
y1(n*fs +2) = 0;

for i = 0:(n*fs -1)
		if stream_bits(floor(i/fs) +1) - '0' == 0
			y1(i+2) = 0;
		else
			y1(i+2) = 1;
		end
end

% Y2 values
y2(1) = 0;
y2(n*fs +2) = 0;
prev = -1;
mem = 0;

if stream_bits(1) - '0' == 0
    y(1)=0;
else
    y(1)=1;
end


% Default graphs -----------------------------------------------

% Plotting Unipolar NRZ --------------------------------------------
subplot(2, 2, 1)
plot(x, y1)
axis([-0.1, n+0.7*n, -1.2, 1.7])
xlabel('Time (sec)')
ylabel('Amplitude')
title('Unipolar NRZ')

% Printing info
text(n+0.2, 1.0, 'r = 0.5')
text(n+0.2, 0.5, 'Bit Rate = 1.0 bps')
text(n+0.2, 0.0, 'Baud Rate = 1.0 baud')
text(n+0.2, -0.5, 'Bandwidth = 1.0 bps')

for i = 0:(n-1)
	text(i+0.5, 1.2, stream_bits(i+1))
end


subplot(2, 2, 3)
plot(x, y2)
axis([-0.1, n+0.7*n, -1.2, 1.7])
xlabel('Time (sec)')
ylabel('Amplitude')
title('MLT-3(Default)')

% Printing info
text(n+0.2, 1.0, 'r = 1.0')
text(n+0.2, 0.5, 'Bit Rate = 1.0 bps')
text(n+0.2, 0.0, 'Baud Rate = 0.5 baud')
text(n+0.2, -0.5, 'Bandwidth = 0.5 bps')

for i = 0:(n-1)
	text(i+0.5, 1.2, stream_bits(i+1))
end

% User graphs --------------------------------------------------

% Plotting Unipolar NRZ --------------------------------------------

% X values
for i = 0:(n*fs)
	x(i+2) = i/fs/bit_rate1;
end

subplot(2, 2, 2)
plot(x, y1)
axis([-0.1, n/bit_rate1+0.7*n/bit_rate1, -1.2, 1.7])
xlabel('Time (sec)')
ylabel('Amplitude')
title('Unipolar NRZ (Modified)')

% Printing info
text(n/bit_rate1+0.2/bit_rate1, 1.0, 'r = 0.5')
text(n/bit_rate1+0.2/bit_rate1, 0.5, strcat(strcat('Bit Rate = ', num2str(bit_rate1)), ' bps'))
text(n/bit_rate1+0.2/bit_rate1, 0.0, strcat(strcat('Baud Rate = ', num2str(bit_rate1)), ' baud'))
text(n/bit_rate1+0.2/bit_rate1, -0.5, strcat(strcat('Bandwidth = ', num2str(bit_rate1)), ' bps'))

for i = 0:(n-1)
	text(i/bit_rate1+0.3/bit_rate1, 1.2, stream_bits(i+1))
end
