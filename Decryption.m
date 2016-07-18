% MATLAB Code for Decryption

img = imread('Encrypted.jpg');                  % IMPORT ENCRYPTED IMAGE FOR DECRYPTION
subplot(1,2,1);
imshow(img);                    
title('Cyphertext of Flowers','FontSize',15);

[xcount, ycount, zcount]=size(img);
N = xcount * ycount;                            % NUMBER OF ITERATIONS

% IKEDA MAP ITERATES FOR DECRYPTION

% PARAMETER VALUES
A=1;
B=0.88;

% PREALLOCATION OF MEMORY FOR x, y, z
z=zeros(1,N);
x=zeros(1,N);
y=zeros(1,N);

% DECRYPTION KEY USED
z(1)=0.1;
x(1)=0.1;
y(1)=0;

% ITERATIONS
for n=1:N
    z(n+1)=A+B*(z(n))*exp(1i*(0.4-6/(1+(abs(z(n)))^2)));
    x(n+1)=real(z(n+1));
    y(n+1)=imag(z(n+1));
end

xmin=min(x);
xmax=max(x);
ymin=min(y);
ymax=max(y);

% COLUMN PLACEMENT--
yval = zeros(1,ycount);
for m=1:1:ycount
	yval(m)=ceil(ycount*(y(m)-ymin)/(ymax-ymin));
end
for m=ycount:-2:1
	p=img(:,yval(m));
    img(:,yval(m))=img(:,yval(m-1));
    img(:,yval(m-1))=p;
    clear p;
end

% ROW PLACEMENT--
xval = zeros(1,xcount);
for n=1:1:xcount
    xval(n)=ceil(xcount*((x(n)-xmin)/(xmax-xmin)));
end
for n=xcount:-2:1
    p=img(xval(n),:);
    img(xval(n),:)=img(xval(n-1),:);
    img(xval(n-1),:)=p;
    clear p;
end

subplot(1,2,2);
imshow(img);                            % GENERATE DECRYPTED IMAGE
title('Decrypted Image of Flowers','FontSize',15);
imwrite(img,'Decrypted.jpg');           % DECRYPTED IMAGE IS SAVED AS 'Encrypted.jpg'
