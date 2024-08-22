generate:
	tuist install
	tuist generate

clean:
	tuist clean
	rm -rf **/**/**/*.xcodeproj
	rm -rf **/**/*.xcodeproj
	rm -rf **/*.xcodeproj
	rm -rf *.xcworkspace

graph:
	tuist graph --skip-external-dependencies

module:
	swift Scripts/GenerateModule.swift
