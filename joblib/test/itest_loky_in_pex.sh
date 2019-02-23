rm -rf ${HOME}/.pex
mkdir -p /tmp/test_loky
cd /tmp/test_loky
rm -rf *
python3.6 -m venv .
. bin/activate
# gets pip 19.0.3
pip install --upgrade pip
pip install pex
pex /Users/j.alberdi/repos/joblib -o ./pex
cat <<EOF > test.py
from joblib import Parallel, delayed

def func(k):
    return k

jobs = (delayed(func)(k) for k in range(2))
print(Parallel(n_jobs=2)(jobs))

EOF
deactivate
./pex test.py
rm -rf /tmp/test_loky
