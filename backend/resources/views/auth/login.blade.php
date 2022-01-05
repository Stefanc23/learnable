@extends('layouts.app')

@section('content')
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <form method="POST" action="{{ route('login') }}">
                    @csrf
                    <h1 class="text-center my-5">Login</h1>
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

                    <div class="form-floating">
                        <input type="password" class="form-control @error('password') is-invalid @enderror" name="password"
                            required autocomplete="current-password" id="password" placeholder="Password">
                        <label for="password">Password</label>
                    </div>

                    @error('password')
                        <span class="invalid-feedback" role="alert">
                            <strong>{{ $message }}</strong>
                        </span>
                    @enderror

                    <div class="d-flex justify-content-between mt-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" name="remember" id="remember"
                                {{ old('remember') ? 'checked' : '' }}>

                            <label class="form-check-label" for="remember">
                                {{ __('Remember Me') }}
                            </label>
                        </div>

                        @if (Route::has('password.request'))
                            <a class="btn btn-link p-0" href="{{ route('password.request') }}">
                                {{ __('Forgot Your Password?') }}
                            </a>
                        @endif
                    </div>

                    <div class="mt-5 text-center">
                        <div class="d-flex justify-content-center mb-2">
                            {{ __('No account yet?') }}&nbsp;&nbsp;
                            <a class="btn btn-link ml-3 p-0" href="{{ route('register') }}">
                                {{ __('Sign up!') }}
                            </a>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 312px;">
                            {{ __('LOG IN') }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection
