import React, { useEffect } from "react";
import Button from "@/Components/Button";
import Checkbox from "@/Components/Checkbox";
import Guest from "@/Layouts/Guest";
import ValidationErrors from "@/Components/ValidationErrors";
import { Head, Link, useForm } from "@inertiajs/inertia-react";
import FloatingLabelInput from "@/Components/FloatingLabelInput";

export default function Login({ status, canResetPassword }) {
    const { data, setData, post, processing, errors, reset } = useForm({
        email: "",
        password: "",
        remember: "",
    });

    useEffect(() => {
        return () => {
            reset("password");
        };
    }, []);

    const onHandleChange = (event) => {
        setData(
            event.target.name,
            event.target.type === "checkbox"
                ? event.target.checked
                : event.target.value
        );
    };

    const submit = (e) => {
        e.preventDefault();

        post(route("login"));
    };

    return (
        <Guest>
            <Head title="Log in" />

            {status && (
                <div className="mb-4 font-medium text-sm text-green-600">
                    {status}
                </div>
            )}

            <ValidationErrors errors={errors} />

            <form onSubmit={submit}>
                <FloatingLabelInput
                    name="email"
                    type="email"
                    value={data.email}
                    autoComplete="username"
                    isFocused={true}
                    className="mt-5"
                    handleChange={onHandleChange}
                    required
                >
                    Email
                </FloatingLabelInput>

                <FloatingLabelInput
                    name="password"
                    type="password"
                    className="mt-4"
                    value={data.password}
                    autoComplete="current-password"
                    handleChange={onHandleChange}
                    required
                >
                    Password
                </FloatingLabelInput>

                <div className="flex justify-between mt-4 block">
                    <label className="flex items-center">
                        <Checkbox
                            name="remember"
                            value={data.remember}
                            handleChange={onHandleChange}
                        />

                        <span className="ml-2 text-sm text-gray-600">
                            Remember me
                        </span>
                    </label>

                    {canResetPassword && (
                        <Link
                            href={route("password.email")}
                            className="underline text-sm text-gray-600 hover:text-gray-900"
                        >
                            Forgot password?
                        </Link>
                    )}
                </div>

                <div className="flex flex-col justify-center items-center mt-8">
                    <Link
                        href={route("register")}
                        className="underline text-sm text-gray-600 hover:text-gray-900"
                    >
                        No account yet?
                    </Link>

                    <Button className="w-full mt-2" processing={processing}>
                        Log in
                    </Button>
                </div>
            </form>
        </Guest>
    );
}
