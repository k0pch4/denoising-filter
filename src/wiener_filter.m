% Main function for giving out a result.
function out_img = wiener_filter(Sxx_avg, img, blur_filter, sigma_)
    gamma = 1;                                % When we have a zero in Sxx,
                                              % we replace by gamma, for
                                              % avoiding NaN.
	[m,n]=size(img);
    H = fft2(blur_filter, m, n);              % Compute DFT of blur_filter
    H_conj = conj(H);                         % Magnitude (element-wise)
    Snn = ones(m,n).*(sigma_^2);
    Sxx_avg(Sxx_avg(:)==0)=gamma;
    k = Snn ./ Sxx_avg;                           % finding the ratio of Sxx/Snn
    df = H_conj./((abs(H).^2) + k);           % deblur_filter
    
    G = fft2(img);                            % convert the distorted to fft
    FFimg = G.*df;
    out_img = imadjust(real(ifft2(FFimg)));   % convert the corrected to time
end
