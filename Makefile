.PHONY: build.hs
build.hs:
	pushd hs && cabal build && popd

.PHONY: build.fs
build.fs:
	pushd fs && dotnet build && popd

.PHONY: test.hs
test.hs:
	pushd hs && cabal test --test-show-details=direct && popd

.PHONY: test.fs
test.fs:
	pushd fs && dotnet test && popd

.PHONY: test.e2e
test.e2e: build.hs build.fs
	bash e2e-test.sh
