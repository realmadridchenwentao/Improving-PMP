function psf = estimate_psf(blurred_x, blurred_y, latent_x, latent_y, weight, psf_size)

    %----------------------------------------------------------------------
    % these values can be pre-computed at the beginning of each level
%     blurred_f = fft2(blurred);
%     dx_f = psf2otf([1 -1 0], size(blurred));
%     dy_f = psf2otf([1;-1;0], size(blurred));
%     blurred_xf = dx_f .* blurred_f; %% FFT (Bx)
%     blurred_yf = dy_f .* blurred_f; %% FFT (By)

    latent_xf = fft2(latent_x);
    latent_yf = fft2(latent_y);
    blurred_xf = fft2(blurred_x);
    blurred_yf = fft2(blurred_y);

    b_f = conj(latent_xf)  .* blurred_xf ...
        + conj(latent_yf)  .* blurred_yf;

    b_z = conj(latent_xf)  .* latent_xf ...
        + conj(latent_yf)  .* latent_yf;

    [nx, ny] = size(b_z);
    [X, Y] = meshgrid(0:nx-1, 0:ny-1);
    rkl = weight * (4-2*cos(2*pi*X/nx)-2*cos(2*pi*Y/ny));

    psf = real(otf2psf(b_f./(b_z+rkl), psf_size));
    psf(psf < max(psf(:))*0.05) = 0;
    psf = psf / sum(psf(:));    
end

function y = compute_Ax(x, p)
    x_f = psf2otf(x, p.img_size);
    y = otf2psf(p.m .* x_f, p.psf_size);
    y = y + p.lambda * x;
end
