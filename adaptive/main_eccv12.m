clear; close all; clc;

addpath(genpath('cho_code'));
          
opts.prescale = 1; % downsampling
opts.xk_iter = 5;  % the iterations
opts.k_thresh = 20;
opts.gamma_correct = 1.0;

for img=1:4
    for blur=1:12
        imgName = ['Blurry',num2str(img),'_',num2str(blur),'.png'];
        disp(['========================== ',imgName,' =========================='])

        filename = ['../BlurryImages/', imgName];
        opts.kernel_size = 41;

        lambda = 0.1; lambda_grad = 4e-3;
        lambda_tv = 1e-3; lambda_l0 = 1e-3; weight_ring = 0;


        y = imread(filename);
        yg = im2double(rgb2gray(y));

        [kernel, interim_latent] = blind_deconv(yg, lambda, lambda_grad, opts);

        y = im2double(y);
        Latent = ringing_artifacts_removal(y, kernel, lambda_tv, lambda_l0, weight_ring);

        k = kernel - min(kernel(:));
        k = k./max(k(:));

        opts.kernel_size = 51;

        [kernel1, interim_latent1] = blind_deconv(yg, lambda, lambda_grad, opts);

        Latent1 = ringing_artifacts_removal(y, kernel1, lambda_tv, lambda_l0, weight_ring);

        k1 = kernel1 - min(kernel1(:));
        k1 = k1./max(k1(:));

        m0 = mean(abs(fft2(yg)), 'all');
        m1 = mean(abs(fft2(Latent)), 'all');
        m2 = mean(abs(fft2(Latent1)), 'all');

        if (m2 > 1.05*m1 && m2<2.5*m0) || m2 < 1.5*m0
            opts.kernel_size = 121;

            [kernel, interim_latent] = blind_deconv(yg, lambda, lambda_grad, opts);

            Latent = ringing_artifacts_removal(y, kernel, lambda_tv, lambda_l0, weight_ring);
    
            k = kernel - min(kernel(:));
            k = k./max(k(:));
        else
            k = k1;
            Latent = Latent1;
        end

        imwrite(k,['../results_eccv12_final/',  'tvmpr_',imgName(7:end-4), '_kernel','.png']);
        imwrite(Latent,['../results_eccv12_final/', 'tvmpr_',imgName(7:end-4), '.png']);
    end
end
