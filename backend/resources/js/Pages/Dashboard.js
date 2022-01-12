import React, { useState } from "react";
import Authenticated from "@/Layouts/Authenticated";
import { Head, useForm, Link } from "@inertiajs/inertia-react";
import { noDataImage, thumbnailImage } from "@/images";
import "tw-elements";
import ValidationErrors from "@/Components/ValidationErrors";
import FloatingLabelInput from "@/Components/FloatingLabelInput";
import Button from "@/Components/Button";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPlus } from "@fortawesome/free-solid-svg-icons";

export default function Dashboard({ user, ...props }) {
    const [classrooms] = useState(user.attended_classes);
    const [selectedBanner, setSelectedBanner] = useState(null);

    const { data, setData, post, processing, errors, reset } =
        useForm({
            name: "",
            classroom_id: "",
            invite_code: "",
            banner: null,
        });

    function createClassroomSubmit(e) {
        e.preventDefault();
        post(route("classroom.create"));
    }

    function joinClassroomSubmit(e) {
        e.preventDefault();
        post(route("classroom.join"));
    }

    return (
        <Authenticated
            auth={props.auth}
            errors={props.errors}
            header={
                <div className="flex justify-between items-center">
                    <h2 className="font-semibold text-xl leading-tight">
                        Classes
                    </h2>
                    <span
                        data-bs-toggle="tooltip"
                        data-bs-placement="bottom"
                        title="Create or join a class"
                    >
                        <button
                            data-bs-toggle="modal"
                            data-bs-target="#createClassModal"
                            type="button"
                            className="text-primary bg-transparent hover:bg-transparent focus:ring-4 focus:ring-transparent font-medium rounded-lg text-sm p-2.5 text-center inline-flex items-center mr-2 dark:bg-transparent dark:hover:bg-transparent dark:focus:ring-transparent"
                        >
                            <FontAwesomeIcon icon={faPlus} size="lg" />
                        </button>
                    </span>
                </div>
            }
        >
            <Head title="Dashboard" />

            <ValidationErrors errors={errors} />

            {classrooms.length == 0 ? (
                <>
                    <div className="flex flex-col justify-center items-center w-full mt-8">
                        <img src={noDataImage} className="w-96" />
                        <p className="text-sm text-primary mt-8">
                            Nothing here yet. Add a class to get started.
                        </p>
                        <div className="flex mt-4">
                            <button
                                type="button"
                                className="inline-block mx-2 px-6 py-2.5 bg-transparent text-primary-600 font-medium text-xs leading-tight uppercase rounded hover:text-white hover:bg-primary active:bg-primary-800 active:text-white transition duration-150 ease-in-out"
                                data-bs-toggle="modal"
                                data-bs-target="#createClassModal"
                            >
                                Create Class
                            </button>
                            <button
                                type="button"
                                className="inline-block mx-2 px-6 py-2.5 bg-primary text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-primary-700 hover:shadow-lg active:bg-primary-800 active:shadow-lg transition duration-150 ease-in-out"
                                data-bs-toggle="modal"
                                data-bs-target="#joinClassModal"
                            >
                                Join Class
                            </button>
                        </div>
                    </div>
                </>
            ) : (
                <div className="flex max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
                    {classrooms.map((classroom) => (
                        <div className="flex justify-center mr-8">
                            <Link href={`/classrooms/${classroom.id}`}>
                                <div className="rounded-md shadow-sm bg-white w-64">
                                    <img
                                        className="rounded-t-lg object-cover h-48"
                                        src={classroom.banner_image_file_path != null ? `/${classroom.banner_image_file_path}` : thumbnailImage}
                                        alt=""
                                    />
                                    <div className="p-6 text-center">
                                        <h5 className="text-gray-900 text-xs font-medium">
                                            {classroom.name}
                                        </h5>
                                    </div>
                                </div>
                            </Link>
                        </div>
                    ))}
                </div>
            )}

            <div
                className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                id="createClassModal"
                tabindex="-1"
                aria-labelledby="createClassModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <form onSubmit={createClassroomSubmit}>
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Create Class
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline"
                                    data-bs-dismiss="modal"
                                    aria-label="Close"
                                ></button>
                            </div>
                            <div className="modal-body relative p-4">
                                <FloatingLabelInput
                                    name="name"
                                    type="text"
                                    value={data.name}
                                    autoComplete="classroom_name"
                                    isFocused={true}
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("name", e.target.value)
                                    }
                                    required
                                >
                                    Class Name
                                </FloatingLabelInput>

                                <FloatingLabelInput
                                    name="invite_code"
                                    type="text"
                                    value={data.invite_code}
                                    autoComplete="new_invite_code"
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("invite_code", e.target.value)
                                    }
                                    required
                                >
                                    Invite Code
                                </FloatingLabelInput>

                                <div className="flex justify-center mt-8">
                                    <div className="max-w-2xl rounded-lg shadow-xl bg-gray-50">
                                        <div className="m-4">
                                            <label className="inline-block mb-2 text-gray-500">
                                                Banner Image
                                            </label>
                                            <div className="flex items-center justify-center w-full">
                                                <label className={`flex flex-col w-full ${selectedBanner == null ? 'h-32' : 'h-fit'} border-4 border-blue-200 border-dashed hover:bg-gray-100 hover:border-gray-300`}>
                                                    {selectedBanner == null ? (
                                                        <div className="flex flex-col items-center justify-center pt-7">
                                                            <svg
                                                                xmlns="http://www.w3.org/2000/svg"
                                                                className="w-8 h-8 text-gray-400 group-hover:text-gray-600"
                                                                fill="none"
                                                                viewBox="0 0 24 24"
                                                                stroke="currentColor"
                                                            >
                                                                <path
                                                                    stroke-linecap="round"
                                                                    stroke-linejoin="round"
                                                                    stroke-width="2"
                                                                    d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                                                                />
                                                            </svg>
                                                            <p className="pt-1 text-sm tracking-wider text-gray-400 group-hover:text-gray-600">
                                                                Attach a file
                                                            </p>
                                                        </div>
                                                    ) : (
                                                        <img className="w-full h-30 object-cover pt-7"
                                                            src={selectedBanner}
                                                        />
                                                    )}
                                                    <input
                                                        id="banner"
                                                        name="banner"
                                                        type="file"
                                                        className="opacity-0"
                                                        onChange={function (e) {
                                                            setData(
                                                                "banner",
                                                                e.target
                                                                    .files[0]
                                                            );
                                                            setSelectedBanner(
                                                                URL.createObjectURL(
                                                                    e.target
                                                                        .files[0]
                                                                )
                                                            );
                                                        }}
                                                    />
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-between p-4 border-t border-gray-200 rounded-b-md">
                                <button
                                    type="button"
                                    className="inline-block bg-transparent pr-8 text-primary-600 font-medium text-xs leading-tight rounded hover:text-primary-700 focus:outline-none focus:ring-0 transition duration-150 ease-in-out"
                                    data-bs-toggle="modal"
                                    data-bs-target="#joinClassModal"
                                >
                                    Join an existing class instead
                                </button>
                                <div className="flex justify-end items-center">
                                    <button
                                        type="button"
                                        className="mr-4 inline-flex items-center justify-center px-6 py-4 rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 bg-transparent hover:bg-primary-500 text-primary-700 hover:text-white border border-primary-500 hover:border-transparent"
                                        data-bs-dismiss="modal"
                                    >
                                        Close
                                    </button>
                                    <Button processing={processing}>
                                        Submit
                                    </Button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <div
                className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                id="joinClassModal"
                tabindex="-1"
                aria-labelledby="joinClassModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <form onSubmit={joinClassroomSubmit}>
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Join Class
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline"
                                    data-bs-dismiss="modal"
                                    aria-label="Close"
                                ></button>
                            </div>
                            <div className="modal-body relative p-4">
                                <FloatingLabelInput
                                    name="classroom_id"
                                    type="text"
                                    value={data.classroom_id}
                                    autoComplete="classroom_id"
                                    isFocused={true}
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("classroom_id", e.target.value)
                                    }
                                    required
                                >
                                    Class ID
                                </FloatingLabelInput>

                                <FloatingLabelInput
                                    name="invite_code"
                                    type="text"
                                    value={data.invite_code}
                                    autoComplete="invite_code"
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("invite_code", e.target.value)
                                    }
                                    required
                                >
                                    Invite Code
                                </FloatingLabelInput>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-between p-4 border-t border-gray-200 rounded-b-md">
                                <button
                                    type="button"
                                    className="inline-block bg-transparent pr-8 text-primary-600 font-medium text-xs leading-tight rounded hover:text-primary-700 focus:outline-none focus:ring-0 transition duration-150 ease-in-out"
                                    data-bs-toggle="modal"
                                    data-bs-target="#createClassModal"
                                >
                                    Create a new class instead
                                </button>
                                <div className="flex justify-end items-center">
                                    <button
                                        type="button"
                                        className="mr-4 inline-flex items-center justify-center px-6 py-4 rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 bg-transparent hover:bg-primary-500 text-primary-700 hover:text-white border border-primary-500 hover:border-transparent"
                                        data-bs-dismiss="modal"
                                    >
                                        Close
                                    </button>
                                    <Button processing={processing}>
                                        Submit
                                    </Button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </Authenticated>
    );
}
