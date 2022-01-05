@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <form method="POST" action="{{ route('register') }}">
                    @csrf
                    <h1 class="text-center my-5">Create Account</h1>

                    <div class="form-floating mb-3">
                        <input type="text" class="form-control @error('name') is-invalid @enderror" id="name"
                            placeholder="Full Name" name="name" value="{{ old('name') }}" required
                            autocomplete="name">
                        <label for="email">Full Name</label>
                    </div>
                    @error('name')
                        <span class="invalid-feedback" role="alert">
                            <strong>{{ $message }}</strong>
                        </span>
                    @enderror

                    <div class="form-floating mb-3">
                        <input type="email" class="form-control @error('email') is-invalid @enderror" id="email"
                            placeholder="name@example.com" name="email" value="{{ old('email') }}" required
                            autocomplete="email">
                        <label for="email">Email address</label>
                    </div>
                    @error('email')
                        <span class="invalid-feedback" role="alert">
                            <strong>{{ $message }}</strong>
                        </span>
                    @enderror

                    <div class="form-floating mb-3">
                        <input type="password" class="form-control @error('password') is-invalid @enderror" name="password"
                            required autocomplete="new-password" id="password" placeholder="Password">
                        <label for="password">Password</label>
                    </div>
                    @error('password')
                        <span class="invalid-feedback" role="alert">
                            <strong>{{ $message }}</strong>
                        </span>
                    @enderror

                    <div class="form-floating">
                        <input type="password" class="form-control" name="password_confirmation" required
                            autocomplete="new-password" id="password-confirm" placeholder="Password">
                        <label for="password-confirm">Confirm Password</label>
                    </div>

                    <div class="mt-5 text-center">
                        <div class="d-flex justify-content-center mb-2">
                            {{ __('Already have an account?') }}&nbsp;&nbsp;
                            <a class="btn btn-link ml-3 p-0" href="{{ route('login') }}">
                                {{ __('Log in!') }}
                            </a>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 312px;">
                            {{ __('SIGN UP') }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
