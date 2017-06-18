% Script file to reorder the Big-endian 3D overthrust volume into two 
% Little-endian 3D volumes, one in each horizontal direction.

clear all;

%salt
%nx=676; ny=676; nz=210;

%overthrust

nx=801; ny=801; nz=187;

% Open Big-endian format file
%fid=fopen('Saltf@@','r','b');

fid=fopen('overthrust.vites','r','b');
frewind(fid)
for islice = 1:nz   % Read data into an array, one slice at a time
wavefield(:,:,islice) = fread(fid,[nx ny],'real*4');
end
fclose(fid) % Close the file identifier

for iz=1:nz
    for ix=1:nx
        pic(iz,ix)=wavefield(ix,50,iz);
    end
end
imagesc(pic);

