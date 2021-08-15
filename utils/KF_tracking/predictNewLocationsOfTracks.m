function tracks = predictNewLocationsOfTracks(tracks)
% Use the Kalman filter to predict the centroid of each track in the
% current frame, and update its bounding box accordingly.

	normalId = strcmp([tracks(:).state],"normal");
	for i=find(normalId)
		bbox = tracks(i).bbox;

		% Predict the current location of the track.
		predictedCentroid = predict(tracks(i).kalmanFilter);

		% Shift the bounding box so that its center is at 
		% the predicted location.
		predictedTFCorner = int32(predictedCentroid) - bbox(3:4) / 2;
		tracks(i).bbox = [predictedTFCorner, bbox(3:4)];
	end
end
