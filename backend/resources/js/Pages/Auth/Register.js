import React, { useEffect } from "react";
import Button from "@/Components/Button";
import Guest from "@/Layouts/Guest";
import Input from "@/Components/Input";
import Label from "@/Components/Label";
import ValidationErrors from "@/Components/ValidationErrors";
import { Head, Link, useForm } from "@inertiajs/inertia-react";
import FloatingLabelInput from "@/Components/FloatingLabelInput";

export default function Register() {
    const { data, setData, post, processing, errors, reset } = useForm({
        name: "",
        email: "",
        password: "",
        password_confirmation: "",
    });

    useEffect(() => {
        return () => {
            reset("password", "password_confirmation");
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

        post(route("register"));
    };

    return (
        <Guest>
            <Head title="Register" />

            <ValidationErrors errors={errors} />

            <form onSubmit={submit}>
                <FloatingLabelInput
                    name="name"
                    type="text"
                    value={data.name}
                    autoComplete="name"
                    isFocused={true}
                    className="mt-5"
                    handleChange={onHandleChange}
                    required
                >
                    Full Name
                </FloatingLabelInput>

                <FloatingLabelInput
                    name="email"
                    type="email"
                    value={data.email}
                    autoComplete="username"
                    className="mt-4"
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
                    autoComplete="new-password"
                    handleChange={onHandleChange}
                    required
                >
                    Password
                </FloatingLabelInput>

                <FloatingLabelInput
                    name="password_confirmation"
                    type="password"
                    className="mt-4"
                    value={data.password_confirmation}
                    handleChange={onHandleChange}
                    required
                >
                    Confirm Password
                </FloatingLabelInput>

                <div className="flex flex-col justify-center items-center mt-8">
                    <Link
                        href={route("login")}
                        className="underline text-sm text-gray-600 hover:text-gray-900"
                    >
                        Already registered?
                    </Link>

                    <Button className="w-full mt-2" processing={processing}>
                        Register
                    </Button>
                </div>
            </form>
        </Guest>
    );
}
