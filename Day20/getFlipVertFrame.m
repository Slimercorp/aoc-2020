function frameOut = getFlipVertFrame(frame)
    frameOut = zeros(10,10);
    for i=1:10
        frameOut(:,i) = frame(:,11-i);
    end
end