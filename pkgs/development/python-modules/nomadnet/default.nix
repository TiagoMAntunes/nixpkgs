{ lib
, buildPythonPackage
, rns
, fetchFromGitHub
, lxmf
, urwid
, pythonOlder
}:

buildPythonPackage rec {
  pname = "nomadnet";
  version = "0.2.3";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "markqvist";
    repo = "NomadNet";
    rev = version;
    hash = "sha256-yArRhJ8NOv/RbjHthnwbz9ieIirq9t5cX9gYcDgEwCw=";
  };

  propagatedBuildInputs = [
    rns
    lxmf
    urwid
  ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [
    "nomadnet"
  ];

  meta = with lib; {
    description = "Off-grid, resilient mesh communication";
    homepage = "https://github.com/markqvist/NomadNet";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ fab ];
  };
}
