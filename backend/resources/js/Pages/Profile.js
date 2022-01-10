import React, { useState } from "react";
import Authenticated from "@/Layouts/Authenticated";
import { Head, useForm } from "@inertiajs/inertia-react";
import { avatarImage } from "@/images";
import "tw-elements";
import ValidationErrors from "@/Components/ValidationErrors";
import FloatingLabelInput from "@/Components/FloatingLabelInput";
import Button from "@/Components/Button";

export default function Profile({ user, ...props }) {
    const [selectedAvatar, setSelectedAvatar] = useState(null);

    const { data, setData, post, progress, processing, errors, reset } =
        useForm({
            name: user.name,
            email: user.email,
            phone_number: user.phone_number,
            date_of_birth: user.date_of_birth,
            gender: user.gender,
            profile: null,
            current_passwprd: "",
            new_password: "",
            new_password_confirmation: "",
        });

    function updateProfileSubmit(e) {
        e.preventDefault();
        post(route("user.update"));
    }

    function changePasswordSubmit(e) {
        e.preventDefault();
        post(route("user.password"));
    }

    return (
        <Authenticated
            auth={props.auth}
            errors={props.errors}
            header={
                <div className="flex justify-between items-center">
                    <h2 className="font-semibold text-xl leading-tight">
                        Profile
                    </h2>
                </div>
            }
        >
            <Head title="Profile" />

            <div className="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                <ValidationErrors errors={errors} />

                <div>
                    <div className="md:grid md:grid-cols-2 md:gap-6">
                        <div className="md:col-span-1 flex justify-between">
                            <div className="px-4 sm:px-0">
                                <h3 className="text-lg font-medium text-gray-900">
                                    Profile information
                                </h3>
                                <p className="mt-1 text-sm text-gray-600">
                                    Update your account's profile information
                                    and email address.
                                </p>
                            </div>
                            <div className="px-4 sm:px-0"></div>
                        </div>
                        <div className="mt-5 md:mt-0 md:col-span-1 bg-white drop-shadow-xl sm:rounded-tl-md sm:rounded-tr-md">
                            <form onSubmit={updateProfileSubmit}>
                                <div className="px-4 py-5 sm:p-6">
                                    <div className="grid grid-cols-6 gap-6">
                                        <div className="col-span-6 flex flex-col justify-center items-center">
                                            <img
                                                class="inline object-cover w-16 h-16 rounded-full"
                                                src={
                                                    selectedAvatar != null
                                                        ? selectedAvatar
                                                        : user.profile_image_file_path !=
                                                          null
                                                        ? `/${user.profile_image_file_path}`
                                                        : avatarImage
                                                }
                                                alt="Profile image"
                                            />
                                            <label
                                                for="profile"
                                                className="cursor-pointer p-3 bg-transparent text-primary font-medium text-xs leading-tight rounded hover:text-primary-400 focus:outline-none focus:ring-0 active:bg-transparent transition duration-150 ease-in-out"
                                            >
                                                Change photo
                                            </label>
                                            <input
                                                type="file"
                                                id="profile"
                                                name="profile"
                                                accept="image/*"
                                                style={{ display: "none" }}
                                                onChange={function (e) {
                                                    setData(
                                                        "profile",
                                                        e.target.files[0]
                                                    );
                                                    setSelectedAvatar(
                                                        URL.createObjectURL(
                                                            e.target.files[0]
                                                        )
                                                    );
                                                }}
                                            />
                                        </div>
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="name"
                                                type="text"
                                                value={data.name}
                                                autoComplete="name"
                                                handleChange={(e) =>
                                                    setData(
                                                        "name",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                Full Name
                                            </FloatingLabelInput>
                                        </div>
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="email"
                                                type="email"
                                                value={data.email}
                                                autoComplete="email"
                                                handleChange={(e) =>
                                                    setData(
                                                        "email",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                Email
                                            </FloatingLabelInput>
                                        </div>
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="phone_number"
                                                type="tel"
                                                value={data.phone_number}
                                                autoComplete="email"
                                                handleChange={(e) =>
                                                    setData(
                                                        "phone_number",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                Phone Number
                                            </FloatingLabelInput>
                                        </div>
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="date_of_birth"
                                                type="date"
                                                value={data.date_of_birth}
                                                autoComplete="date_of_birth"
                                                handleChange={(e) =>
                                                    setData(
                                                        "date_of_birth",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                Date of Birth
                                            </FloatingLabelInput>
                                        </div>
                                        <div className="col-span-6">
                                            <select
                                                class="form-select appearance-none block w-full p-2 font-normal text-gray-700 bg-white bg-clip-padding bg-no-repeat border border-primary rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-primary-600 focus:outline-none"
                                                aria-label="gender-select"
                                                onChange={(e) =>
                                                    setData(
                                                        "gender",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                <option
                                                    selected={
                                                        user.gender == null
                                                    }
                                                >
                                                    Gender
                                                </option>
                                                <option
                                                    value="Male"
                                                    selected={
                                                        user.gender == "Male"
                                                    }
                                                >
                                                    Male
                                                </option>
                                                <option
                                                    value="Female"
                                                    selected={
                                                        user.gender == "Female"
                                                    }
                                                >
                                                    Female
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div className="flex items-center justify-end px-4 py-3 bg-gray-50 text-right sm:px-6 sm:rounded-bl-md sm:rounded-br-md">
                                    <div className="mr-3">
                                        <div
                                            className="text-sm text-gray-600"
                                            style={{ display: "none" }}
                                        >
                                            Saved.
                                        </div>
                                    </div>
                                    <Button processing={processing}>
                                        Save
                                    </Button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div className="mt-16">
                    <div className="md:grid md:grid-cols-2 md:gap-6">
                        <div className="md:col-span-1 flex justify-between">
                            <div className="px-4 sm:px-0">
                                <h3 className="text-lg font-medium text-gray-900">
                                    Change password
                                </h3>
                                <p className="mt-1 text-sm text-gray-600">
                                    Update your login password.
                                </p>
                            </div>
                            <div className="px-4 sm:px-0"></div>
                        </div>
                        <div className="mt-5 md:mt-0 md:col-span-1 bg-white drop-shadow-xl sm:rounded-tl-md sm:rounded-tr-md">
                            <form onSubmit={changePasswordSubmit}>
                                <div className="px-4 py-5 sm:p-6">
                                    <div className="grid grid-cols-6 gap-6">
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="current_password"
                                                type="password"
                                                value={data.current_password}
                                                autoComplete="current_password"
                                                handleChange={(e) =>
                                                    setData(
                                                        "current_password",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                Current Password
                                            </FloatingLabelInput>
                                        </div>
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="new_password"
                                                type="password"
                                                className="mt-4"
                                                value={data.new_password}
                                                handleChange={(e) =>
                                                    setData(
                                                        "new_password",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                New Password
                                            </FloatingLabelInput>
                                        </div>
                                        <div className="col-span-6">
                                            <FloatingLabelInput
                                                name="new_password_confirmation"
                                                type="password"
                                                className="mt-4"
                                                value={data.new_password_confirmation}
                                                handleChange={(e) =>
                                                    setData(
                                                        "new_password_confirmation",
                                                        e.target.value
                                                    )
                                                }
                                                required
                                            >
                                                Confirm New Password
                                            </FloatingLabelInput>
                                        </div>
                                    </div>
                                </div>
                                <div className="flex items-center justify-end px-4 py-3 bg-gray-50 text-right sm:px-6 sm:rounded-bl-md sm:rounded-br-md">
                                    <div className="mr-3">
                                        <div
                                            className="text-sm text-gray-600"
                                            style={{ display: "none" }}
                                        >
                                            Saved.
                                        </div>
                                    </div>
                                    <Button processing={processing}>
                                        Save
                                    </Button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </Authenticated>
    );
}
