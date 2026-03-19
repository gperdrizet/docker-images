# PyTorch source build

Documentation: [`pytorch/pytorch#from-source`](https://github.com/pytorch/pytorch#from-source)

## Get source

```text
git clone https://github.com/pytorch/pytorch
cd pytorch
```

## Set-up pip

```text
pip install --root-user-action=ignore --upgrade pip
pip install --root-user-action=ignore --group dev
```

Don't add LAPACK or magma or Triton...

## Build

```text
python -m pip install --root-user-action ignore --no-build-isolation -v -e .
```


