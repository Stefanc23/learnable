import React, { useState } from "react";
import Authenticated from "@/Layouts/Authenticated";
import { Head, useForm, Link } from "@inertiajs/inertia-react";
import { thumbnailImage, avatarImage } from "@/images";
import "tw-elements";
import ValidationErrors from "@/Components/ValidationErrors";
import FloatingLabelInput from "@/Components/FloatingLabelInput";
import Button from "@/Components/Button";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import Datetime from "react-datetime";
import "react-datetime/css/react-datetime.css";
import moment from "moment";
import {
    faCog,
    faPlus,
    faDownload,
    faTrash,
    faUpload,
    faHistory,
    faClipboardList,
} from "@fortawesome/free-solid-svg-icons";
import { CopyToClipboard } from "react-copy-to-clipboard";

export default function Classroom({ classroom, assignments, ...props }) {
    const [selectedAssignmentId, setSelectedAssignmentId] = useState(0);
    const [selectedAssignmentIndex, setSelectedAssignmentIndex] = useState(0);
    const [selectedBanner, setSelectedBanner] = useState(null);

    const { data, setData, post, processing, errors, reset } = useForm({
        name: classroom.name,
        invite_code: classroom.invite_code,
        title: "",
        deadline: "",
        banner: null,
        assignment: null,
        submission: null,
        material: null,
    });

    function editClassroomSubmit(e) {
        e.preventDefault();
        post(route("classroom.update", { id: classroom.id }));
    }

    function addAssignmentSubmit(e) {
        e.preventDefault();
        post(route("assignment.add", { classroom: classroom.id }));
    }

    function addSubmissionSubmit(e) {
        e.preventDefault();
        post(
            route("submission.add", {
                assignment: selectedAssignmentId,
            })
        );
    }

    function addMaterialSubmit(e) {
        e.preventDefault();
        post(route("material.add", { classroom: classroom.id }));
    }

    console.log(data, assignments, classroom);

    return (
        <Authenticated
            auth={props.auth}
            errors={props.errors}
            header={
                <>
                    <div className="flex justify-between items-center">
                        <div className="flex">
                            <h2 className="font-semibold text-xl leading-tight">
                                {classroom.name}
                            </h2>
                            {classroom.class_attendees[0].id ==
                                props.auth.user.id && (
                                <button
                                    className="ml-6"
                                    type="button"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editClassroomModal"
                                >
                                    <FontAwesomeIcon
                                        icon={faCog}
                                        size="lg"
                                        className="text-primary"
                                    />
                                </button>
                            )}
                        </div>

                        <ul
                            className="nav nav-tabs flex flex-col md:flex-row flex-wrap list-none border-b-0 pl-0 mb-4"
                            id="tabs-tab"
                            role="tablist"
                        >
                            <li className="nav-item" role="presentation">
                                <a
                                    href="#tabs-people"
                                    className="nav-link w-full block font-medium text-xs leading-tight uppercase border-x-0 border-t-0 border-b-2 border-transparent px-6 py-3 my-2 hover:border-transparent hover:bg-primary hover:text-white focus:border-transparent active"
                                    id="tabs-people-tab"
                                    data-bs-toggle="pill"
                                    data-bs-target="#tabs-people"
                                    role="tab"
                                    aria-controls="tabs-people"
                                    aria-selected="true"
                                >
                                    People
                                </a>
                            </li>
                            <li className="nav-item" role="presentation">
                                <a
                                    href="#tabs-assignment"
                                    className="nav-link w-full block font-medium text-xs leading-tight uppercase border-x-0 border-t-0 border-b-2 border-transparent px-6 py-3 my-2 hover:border-transparent hover:bg-primary hover:text-white focus:border-transparent"
                                    id="tabs-assignment-tab"
                                    data-bs-toggle="pill"
                                    data-bs-target="#tabs-assignment"
                                    role="tab"
                                    aria-controls="tabs-assignment"
                                    aria-selected="true"
                                >
                                    Assignment
                                </a>
                            </li>
                            <li className="nav-item" role="presentation">
                                <a
                                    href="#tabs-material"
                                    className="nav-link w-full block font-medium text-xs leading-tight uppercase border-x-0 border-t-0 border-b-2 border-transparent px-6 py-3 my-2 hover:border-transparent hover:bg-primary hover:text-white focus:border-transparent"
                                    id="tabs-material-tab"
                                    data-bs-toggle="pill"
                                    data-bs-target="#tabs-material"
                                    role="tab"
                                    aria-controls="tabs-material"
                                    aria-selected="true"
                                >
                                    Material
                                </a>
                            </li>
                            {/* <li className="nav-item" role="presentation">
                                <a
                                    href="#tabs-forum"
                                    className="nav-link w-full block font-medium text-xs leading-tight uppercase border-x-0 border-t-0 border-b-2 border-transparent px-6 py-3 my-2 hover:border-transparent hover:bg-primary hover:text-white focus:border-transparent"
                                    id="tabs-forum-tab"
                                    data-bs-toggle="pill"
                                    data-bs-target="#tabs-forum"
                                    role="tab"
                                    aria-controls="tabs-forum"
                                    aria-selected="true"
                                >
                                    Forum
                                </a>
                            </li> */}
                        </ul>
                    </div>

                    {classroom.banner_image_file_path != null && (
                        <img
                            class="object-cover w-full h-72 rounded-lg shadow"
                            src={`/${classroom.banner_image_file_path}`}
                            alt="Classroom Banner"
                        />
                    )}
                </>
            }
        >
            <Head title={classroom.name} />

            <div className="max-w-7xl mx-auto py-2 sm:px-6 lg:px-8">
                <ValidationErrors errors={errors} />

                <div className="tab-content" id="tabs-tabContent">
                    <div
                        className="tab-pane fade show active"
                        id="tabs-people"
                        role="tabpanel"
                        aria-labelledby="tabs-people-tab"
                    >
                        <div class="flex flex-col">
                            <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
                                <div class="py-4 inline-block min-w-full sm:px-8 lg:px-16">
                                    <div class="overflow-hidden flex flex-col items-end">
                                        {classroom.class_attendees[0].id ==
                                            props.auth.user.id && (
                                            <button
                                                type="button"
                                                className="mb-8 px-6 py-2.5 bg-transparent text-primary font-medium text-xs leading-tight uppercase rounded hover:text-white hover:bg-primary active:bg-primary-800 active:text-white transition duration-150 ease-in-out"
                                                data-bs-toggle="modal"
                                                data-bs-target="#invitePeopleModal"
                                            >
                                                <FontAwesomeIcon
                                                    icon={faPlus}
                                                    size="lg"
                                                    className="mr-2"
                                                />
                                                Invite People
                                            </button>
                                        )}
                                        <table class="min-w-full text-left">
                                            <thead class="border-b bg-primary text-start">
                                                <tr>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        #
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        User
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Role
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {classroom.class_attendees.map(
                                                    (attendee, index) => (
                                                        <tr
                                                            class={`bg-white border-b`}
                                                        >
                                                            <td class="px-4 py-4 whitespace-nowrap text-sm font-medium text-primary-900">
                                                                {index + 1}
                                                            </td>
                                                            <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                <img
                                                                    class="inline object-cover w-8 h-8 rounded-full mr-4"
                                                                    src={
                                                                        attendee.profile_image_file_path !=
                                                                        null
                                                                            ? `/${attendee.profile_image_file_path}`
                                                                            : avatarImage
                                                                    }
                                                                    alt="Profile image"
                                                                />
                                                                {`${
                                                                    attendee.name
                                                                }${
                                                                    attendee.id ==
                                                                    props.auth
                                                                        .user.id
                                                                        ? " (You)"
                                                                        : ""
                                                                }`}
                                                            </td>
                                                            <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                {
                                                                    attendee
                                                                        .pivot
                                                                        .role
                                                                }
                                                            </td>
                                                        </tr>
                                                    )
                                                )}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="tab-pane fade"
                        id="tabs-assignment"
                        role="tabpanel"
                        aria-labelledby="tabs-assignment-tab"
                    >
                        <div class="flex flex-col">
                            <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
                                <div class="py-4 inline-block min-w-full sm:px-8 lg:px-16">
                                    <div class="overflow-hidden flex flex-col items-end">
                                        {classroom.class_attendees[0].id ==
                                            props.auth.user.id && (
                                            <button
                                                type="button"
                                                className="mb-8 px-6 py-2.5 bg-transparent text-primary font-medium text-xs leading-tight uppercase rounded hover:text-white hover:bg-primary active:bg-primary-800 active:text-white transition duration-150 ease-in-out"
                                                data-bs-toggle="modal"
                                                data-bs-target="#addAssignmentModal"
                                            >
                                                <FontAwesomeIcon
                                                    icon={faPlus}
                                                    size="lg"
                                                    className="mr-2"
                                                />
                                                Add New Assignment
                                            </button>
                                        )}
                                        <table class="min-w-full text-left">
                                            <thead class="border-b bg-primary text-start">
                                                <tr>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Assignment Title
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Date Added
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Deadline
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {assignments.length == 0 ? (
                                                    <tr
                                                        class={`bg-white border-b`}
                                                    >
                                                        <td
                                                            colspan="4"
                                                            class="px-4 py-4 whitespace-nowrap text-sm text-primary-900 text-center"
                                                        >
                                                            Nothing here yet.
                                                        </td>
                                                    </tr>
                                                ) : (
                                                    assignments.map(
                                                        (assignment, index) => (
                                                            <tr
                                                                class={`${
                                                                    new Date(
                                                                        assignment.deadline
                                                                    ).getTime() <
                                                                    new Date().getTime()
                                                                        ? "bg-red-400"
                                                                        : "bg-white"
                                                                } border-b`}
                                                            >
                                                                <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                    {
                                                                        assignment.title
                                                                    }
                                                                </td>
                                                                <td class="px-4 py-4 whitespace-nowrap text-sm text-primary-900">
                                                                    {assignment.created_at.substring(
                                                                        0,
                                                                        10
                                                                    )}
                                                                </td>
                                                                <td class="px-4 py-4 whitespace-nowrap text-sm text-primary-900">
                                                                    {assignment.deadline.substring(
                                                                        0,
                                                                        10
                                                                    )}{" "}
                                                                    (
                                                                    {assignment.deadline.substring(
                                                                        11,
                                                                        16
                                                                    )}
                                                                    )
                                                                </td>
                                                                <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap flex">
                                                                    <a
                                                                        href={`/${assignment.assignment_file_path}`}
                                                                        target="_blank"
                                                                    >
                                                                        <FontAwesomeIcon
                                                                            icon={
                                                                                faDownload
                                                                            }
                                                                            size="lg"
                                                                            className="text-primary"
                                                                        />
                                                                    </a>
                                                                    {classroom
                                                                        .class_attendees[0]
                                                                        .id ==
                                                                    props.auth
                                                                        .user
                                                                        .id ? (
                                                                        <>
                                                                            <button
                                                                                className="ml-3"
                                                                                type="button"
                                                                                data-bs-toggle="modal"
                                                                                data-bs-target="#viewSubmissionsModal"
                                                                                onClick={() =>
                                                                                    setSelectedAssignmentIndex(
                                                                                        index
                                                                                    )
                                                                                }
                                                                            >
                                                                                <FontAwesomeIcon
                                                                                    icon={
                                                                                        faClipboardList
                                                                                    }
                                                                                    size="lg"
                                                                                    className={`text-primary`}
                                                                                />
                                                                            </button>
                                                                            <Link
                                                                                className="ml-3"
                                                                                href={`/assignments/${assignment.id}`}
                                                                                method="delete"
                                                                                as="button"
                                                                                type="button"
                                                                            >
                                                                                <FontAwesomeIcon
                                                                                    icon={
                                                                                        faTrash
                                                                                    }
                                                                                    size="lg"
                                                                                    className="text-red-600"
                                                                                />
                                                                            </Link>
                                                                        </>
                                                                    ) : (
                                                                        <>
                                                                            {new Date(
                                                                                assignment.deadline
                                                                            ).getTime() >
                                                                                new Date().getTime() && (
                                                                                <button
                                                                                    className="ml-3"
                                                                                    type="button"
                                                                                    data-bs-toggle="modal"
                                                                                    data-bs-target="#addSubmissionModal"
                                                                                    onClick={() =>
                                                                                        setSelectedAssignmentId(
                                                                                            assignment.id
                                                                                        )
                                                                                    }
                                                                                >
                                                                                    <FontAwesomeIcon
                                                                                        icon={
                                                                                            faUpload
                                                                                        }
                                                                                        size="lg"
                                                                                        className={`text-primary`}
                                                                                    />
                                                                                </button>
                                                                            )}
                                                                            <button
                                                                                className="ml-3"
                                                                                type="button"
                                                                                data-bs-toggle="modal"
                                                                                data-bs-target="#viewSubmissionsModal"
                                                                                onClick={() =>
                                                                                    setSelectedAssignmentId(
                                                                                        assignment.id
                                                                                    )
                                                                                }
                                                                            >
                                                                                <FontAwesomeIcon
                                                                                    icon={
                                                                                        faHistory
                                                                                    }
                                                                                    size="lg"
                                                                                    className={`text-primary`}
                                                                                />
                                                                            </button>
                                                                        </>
                                                                    )}
                                                                </td>
                                                            </tr>
                                                        )
                                                    )
                                                )}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="tab-pane fade"
                        id="tabs-material"
                        role="tabpanel"
                        aria-labelledby="tabs-material-tab"
                    >
                        <div class="flex flex-col">
                            <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
                                <div class="py-4 inline-block min-w-full sm:px-8 lg:px-16">
                                    <div class="overflow-hidden flex flex-col items-end">
                                        {classroom.class_attendees[0].id ==
                                            props.auth.user.id && (
                                            <button
                                                type="button"
                                                className="mb-8 px-6 py-2.5 bg-transparent text-primary font-medium text-xs leading-tight uppercase rounded hover:text-white hover:bg-primary active:bg-primary-800 active:text-white transition duration-150 ease-in-out"
                                                data-bs-toggle="modal"
                                                data-bs-target="#addMaterialModal"
                                            >
                                                <FontAwesomeIcon
                                                    icon={faPlus}
                                                    size="lg"
                                                    className="mr-2"
                                                />
                                                Add New Material
                                            </button>
                                        )}
                                        <table class="min-w-full text-left">
                                            <thead class="border-b bg-primary text-start">
                                                <tr>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Date Added
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Material Title
                                                    </th>
                                                    <th
                                                        scope="col"
                                                        class="text-sm font-medium text-white px-4 py-4"
                                                    >
                                                        Actions
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {classroom.materials.length ==
                                                0 ? (
                                                    <tr
                                                        class={`bg-white border-b`}
                                                    >
                                                        <td
                                                            colspan="3"
                                                            class="px-4 py-4 whitespace-nowrap text-sm text-primary-900 text-center"
                                                        >
                                                            Nothing here yet.
                                                        </td>
                                                    </tr>
                                                ) : (
                                                    classroom.materials.map(
                                                        (material) => (
                                                            <tr
                                                                class={`bg-white border-b`}
                                                            >
                                                                <td class="px-4 py-4 whitespace-nowrap text-sm text-primary-900">
                                                                    {material.created_at.substring(
                                                                        0,
                                                                        10
                                                                    )}
                                                                </td>
                                                                <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                    {
                                                                        material.title
                                                                    }
                                                                </td>
                                                                <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap flex">
                                                                    <a
                                                                        href={`/${material.material_file_path}`}
                                                                        target="_blank"
                                                                    >
                                                                        <FontAwesomeIcon
                                                                            icon={
                                                                                faDownload
                                                                            }
                                                                            size="lg"
                                                                            className="text-primary"
                                                                        />
                                                                    </a>
                                                                    {classroom
                                                                        .class_attendees[0]
                                                                        .id ==
                                                                        props
                                                                            .auth
                                                                            .user
                                                                            .id && (
                                                                        <Link
                                                                            className="ml-3"
                                                                            href={`/materials/${material.id}`}
                                                                            method="delete"
                                                                            as="button"
                                                                            type="button"
                                                                        >
                                                                            <FontAwesomeIcon
                                                                                icon={
                                                                                    faTrash
                                                                                }
                                                                                size="lg"
                                                                                className="text-red-600"
                                                                            />
                                                                        </Link>
                                                                    )}
                                                                </td>
                                                            </tr>
                                                        )
                                                    )
                                                )}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    {/* <div
                        className="tab-pane fade"
                        id="tabs-forum"
                        role="tabpanel"
                        aria-labelledby="tabs-forum-tab"
                    >
                        Forum
                    </div> */}
                </div>
            </div>
            <div
                className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                id="editClassroomModal"
                tabindex="-1"
                aria-labelledby="editClassroomModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <form className="w-full" onSubmit={editClassroomSubmit}>
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Classroom Details
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline"
                                    data-bs-dismiss="modal"
                                    aria-label="Close"
                                ></button>
                            </div>
                            <div className="modal-body relative p-4">
                                <p class="inline-block mb-2 text-gray-700">
                                    Classroom Banner
                                </p>
                                <img
                                    class="object-cover w-full h-64"
                                    src={
                                        selectedBanner != null
                                            ? selectedBanner
                                            : classroom.banner_image_file_path !=
                                              null
                                            ? `/${classroom.banner_image_file_path}`
                                            : thumbnailImage
                                    }
                                    alt="Classroom Banner"
                                />
                                <label
                                    for="banner"
                                    className="cursor-pointer p-3 bg-transparent text-primary font-medium text-xs leading-tight rounded hover:text-primary-400 focus:outline-none focus:ring-0 active:bg-transparent transition duration-150 ease-in-out"
                                >
                                    Change banner
                                </label>
                                <input
                                    type="file"
                                    id="banner"
                                    name="banner"
                                    accept="image/*"
                                    style={{ display: "none" }}
                                    onChange={function (e) {
                                        setData("banner", e.target.files[0]);
                                        setSelectedBanner(
                                            URL.createObjectURL(
                                                e.target.files[0]
                                            )
                                        );
                                    }}
                                />
                                <FloatingLabelInput
                                    type="text"
                                    className="mt-5"
                                    value={classroom.id}
                                    disabled
                                >
                                    Classroom ID
                                </FloatingLabelInput>
                                <FloatingLabelInput
                                    name="name"
                                    type="text"
                                    className="mt-5"
                                    value={data.name}
                                    handleChange={(e) =>
                                        setData("name", e.target.value)
                                    }
                                    required
                                >
                                    Classroom Name
                                </FloatingLabelInput>
                                <FloatingLabelInput
                                    name="invite_code"
                                    type="text"
                                    className="mt-5"
                                    value={data.invite_code}
                                    handleChange={(e) =>
                                        setData("invite_code", e.target.value)
                                    }
                                    required
                                >
                                    Invite Code
                                </FloatingLabelInput>
                            </div>

                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
                                <div className="flex justify-end items-center">
                                    <button
                                        type="button"
                                        className="mr-4 inline-flex items-center justify-center px-6 py-4 rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 bg-transparent hover:bg-primary-500 text-primary-700 hover:text-white border border-primary-500 hover:border-transparent"
                                        data-bs-dismiss="modal"
                                    >
                                        Close
                                    </button>
                                    <button className="inline-flex items-center justify-center px-6 py-4 bg-primary hover:bg-primary-400 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150">
                                        Save
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div
                className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                id="invitePeopleModal"
                tabindex="-1"
                aria-labelledby="invitePeopleModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                        <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                            <h5
                                className="text-xl font-medium leading-normal text-gray-800"
                                id="exampleModalScrollableLabel"
                            >
                                Invite People
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
                                type="text"
                                className="mt-5"
                                value={classroom.id}
                                disabled
                            >
                                Classroom ID
                            </FloatingLabelInput>
                            <FloatingLabelInput
                                type="text"
                                className="mt-5"
                                value={classroom.invite_code}
                                disabled
                            >
                                Invite Code
                            </FloatingLabelInput>
                        </div>

                        <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
                            <div className="flex justify-end items-center">
                                <button
                                    type="button"
                                    className="mr-4 inline-flex items-center justify-center px-6 py-4 rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 bg-transparent hover:bg-primary-500 text-primary-700 hover:text-white border border-primary-500 hover:border-transparent"
                                    data-bs-dismiss="modal"
                                >
                                    Close
                                </button>
                                <CopyToClipboard
                                    options={{
                                        debug: props.debug,
                                        message: "",
                                    }}
                                    onCopy={function () {}}
                                    text={`Join ${classroom.name} @Learnable\nClassroom ID: ${classroom.id}\nClassroom Invite Code: ${classroom.invite_code}`}
                                >
                                    <button className="inline-flex items-center justify-center px-6 py-4 bg-primary hover:bg-primary-400 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150">
                                        Copy to Clipboard
                                    </button>
                                </CopyToClipboard>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div
                className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                id="addAssignmentModal"
                tabindex="-1"
                aria-labelledby="addAssignmentModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <form className="w-full" onSubmit={addAssignmentSubmit}>
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Add New Assignment
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
                                    name="assignment_title"
                                    type="text"
                                    value={data.title}
                                    autoComplete="assignment_title"
                                    isFocused={true}
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("title", e.target.value)
                                    }
                                    required
                                >
                                    Assignment Title
                                </FloatingLabelInput>
                                <div className="mt-4">
                                    Deadline
                                    <Datetime
                                        dateFormat="DD-MM-YYYY"
                                        timeFormat="HH:mm"
                                        onChange={function (e) {
                                            setData(
                                                "deadline",
                                                moment(e._d).format(
                                                    "YYYY-MM-DD HH:mm"
                                                )
                                            );
                                        }}
                                    />
                                </div>
                                <div class="flex justify-start mt-6">
                                    <div class="mb-3 w-96">
                                        <label
                                            for="formFile"
                                            class="form-label inline-block mb-2 text-gray-700"
                                        >
                                            Assignment File
                                        </label>
                                        <input
                                            class="form-control block w-full px-3 py-1.5 text-base font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                                            type="file"
                                            required
                                            id="formFile"
                                            onChange={function (e) {
                                                setData(
                                                    "assignment",
                                                    e.target.files[0]
                                                );
                                            }}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
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
                id="addSubmissionModal"
                tabindex="-1"
                aria-labelledby="addSubmissionModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <form className="w-full" onSubmit={addSubmissionSubmit}>
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Add New Submission
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
                                    name="submission_title"
                                    type="text"
                                    value={data.title}
                                    autoComplete="submission_title"
                                    isFocused={true}
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("title", e.target.value)
                                    }
                                    required
                                >
                                    Submission Title
                                </FloatingLabelInput>
                                <div class="flex justify-start mt-6">
                                    <div class="mb-3 w-96">
                                        <label
                                            for="formFile"
                                            class="form-label inline-block mb-2 text-gray-700"
                                        >
                                            Submission File
                                        </label>
                                        <input
                                            class="form-control block w-full px-3 py-1.5 text-base font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                                            type="file"
                                            required
                                            id="formFile"
                                            onChange={function (e) {
                                                setData(
                                                    "submission",
                                                    e.target.files[0]
                                                );
                                            }}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
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
            {classroom.class_attendees[0].id == props.auth.user.id ? (
                <div
                    className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                    id="viewSubmissionsModal"
                    tabindex="-1"
                    aria-labelledby="viewSubmissionsModalTitle"
                    aria-modal="true"
                    role="dialog"
                >
                    <div className="modal-dialog modal-dialog-centered relative max-w-7xl pointer-events-none">
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Submissions
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline"
                                    data-bs-dismiss="modal"
                                    aria-label="Close"
                                ></button>
                            </div>
                            <div className="modal-body relative p-4">
                                <div class="flex flex-col">
                                    <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
                                        <div class="py-4 inline-block min-w-full px-8">
                                            <div class="overflow-hidden flex flex-col items-end">
                                                <table class="min-w-full text-left">
                                                    <thead class="border-b bg-primary text-start">
                                                        <tr>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Submission Title
                                                            </th>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Student
                                                            </th>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Submission Date
                                                            </th>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Actions
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {assignments.length ==
                                                            0 ||
                                                        assignments[
                                                            selectedAssignmentIndex
                                                        ].submissions.length ==
                                                            0 ? (
                                                            <tr
                                                                class={`bg-white border-b`}
                                                            >
                                                                <td
                                                                    colspan="4"
                                                                    class="px-4 py-4 whitespace-nowrap text-sm text-primary-900 text-center"
                                                                >
                                                                    Nothing here
                                                                    yet.
                                                                </td>
                                                            </tr>
                                                        ) : (
                                                            assignments[
                                                                selectedAssignmentIndex
                                                            ].submissions.map(
                                                                (
                                                                    submission,
                                                                    index
                                                                ) => (
                                                                    <tr
                                                                        class={`bg-white border-b`}
                                                                    >
                                                                        <td class="px-4 py-4 whitespace-nowrap text-sm font-medium text-primary-900">
                                                                            {
                                                                                submission.title
                                                                            }
                                                                        </td>
                                                                        <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                            <img
                                                                                class="inline object-cover w-8 h-8 rounded-full mr-4"
                                                                                src={
                                                                                    submission
                                                                                        .user
                                                                                        .profile_image_file_path !=
                                                                                    null
                                                                                        ? `/${submission.user.profile_image_file_path}`
                                                                                        : avatarImage
                                                                                }
                                                                                alt="Profile image"
                                                                            />
                                                                            {`${submission.user.name}`}
                                                                        </td>
                                                                        <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                            {submission.created_at.substring(
                                                                                0,
                                                                                10
                                                                            )}{" "}
                                                                            (
                                                                            {submission.created_at.substring(
                                                                                11,
                                                                                16
                                                                            )}
                                                                            )
                                                                        </td>
                                                                        <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                            <a
                                                                                href={`/${submission.submission_file_path}`}
                                                                                target="_blank"
                                                                            >
                                                                                <FontAwesomeIcon
                                                                                    icon={
                                                                                        faDownload
                                                                                    }
                                                                                    size="lg"
                                                                                    className="text-primary"
                                                                                />
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                )
                                                            )
                                                        )}
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
                                <div className="flex justify-end items-center">
                                    <button
                                        type="button"
                                        className="mr-4 inline-flex items-center justify-center px-6 py-4 rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 bg-transparent hover:bg-primary-500 text-primary-700 hover:text-white border border-primary-500 hover:border-transparent"
                                        data-bs-dismiss="modal"
                                    >
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            ) : (
                <div
                    className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                    id="viewSubmissionsModal"
                    tabindex="-1"
                    aria-labelledby="viewSubmissionsModalTitle"
                    aria-modal="true"
                    role="dialog"
                >
                    <div className="modal-dialog modal-dialog-centered relative max-w-7xl pointer-events-none">
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Submissions
                                </h5>
                                <button
                                    type="button"
                                    className="btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline"
                                    data-bs-dismiss="modal"
                                    aria-label="Close"
                                ></button>
                            </div>
                            <div className="modal-body relative p-4">
                                <div class="flex flex-col">
                                    <div class="overflow-x-auto sm:-mx-6 lg:-mx-8">
                                        <div class="py-4 inline-block min-w-full px-8">
                                            <div class="overflow-hidden flex flex-col items-end">
                                                <table class="min-w-full text-left">
                                                    <thead class="border-b bg-primary text-start">
                                                        <tr>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Submission Title
                                                            </th>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Submission Date
                                                            </th>
                                                            <th
                                                                scope="col"
                                                                class="text-sm font-medium text-white px-4 py-4"
                                                            >
                                                                Actions
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {assignments.length ==
                                                            0 ||
                                                        assignments[
                                                            selectedAssignmentIndex
                                                        ].submission_histories
                                                            .length == 0 ? (
                                                            <tr
                                                                class={`bg-white border-b`}
                                                            >
                                                                <td
                                                                    colspan="3"
                                                                    class="px-4 py-4 whitespace-nowrap text-sm text-primary-900 text-center"
                                                                >
                                                                    Nothing here
                                                                    yet.
                                                                </td>
                                                            </tr>
                                                        ) : (
                                                            assignments[
                                                                selectedAssignmentIndex
                                                            ].submission_histories.map(
                                                                (
                                                                    submission,
                                                                    index
                                                                ) => (
                                                                    <tr
                                                                        class={`bg-white border-b`}
                                                                    >
                                                                        <td class="px-4 py-4 whitespace-nowrap text-sm font-medium text-primary-900">
                                                                            {
                                                                                submission.title
                                                                            }
                                                                        </td>
                                                                        <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                            {submission.created_at.substring(
                                                                                0,
                                                                                10
                                                                            )}{" "}
                                                                            (
                                                                            {submission.created_at.substring(
                                                                                11,
                                                                                16
                                                                            )}
                                                                            )
                                                                        </td>
                                                                        <td class="text-sm text-primary-900 font-light px-4 py-4 whitespace-nowrap">
                                                                            {index ==
                                                                                0 && (
                                                                                <a
                                                                                    href={`/${submission.submission.submission_file_path}`}
                                                                                    target="_blank"
                                                                                >
                                                                                    <FontAwesomeIcon
                                                                                        icon={
                                                                                            faDownload
                                                                                        }
                                                                                        size="lg"
                                                                                        className="text-primary"
                                                                                    />
                                                                                </a>
                                                                            )}
                                                                        </td>
                                                                    </tr>
                                                                )
                                                            )
                                                        )}
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
                                <div className="flex justify-end items-center">
                                    <button
                                        type="button"
                                        className="mr-4 inline-flex items-center justify-center px-6 py-4 rounded-md font-semibold text-xs text-white uppercase tracking-widest active:bg-primary transition ease-in-out duration-150 bg-transparent hover:bg-primary-500 text-primary-700 hover:text-white border border-primary-500 hover:border-transparent"
                                        data-bs-dismiss="modal"
                                    >
                                        Close
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            )}

            <div
                className="modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto"
                id="addMaterialModal"
                tabindex="-1"
                aria-labelledby="addMaterialModalTitle"
                aria-modal="true"
                role="dialog"
            >
                <div className="modal-dialog modal-dialog-centered relative w-auto pointer-events-none">
                    <form className="w-full" onSubmit={addMaterialSubmit}>
                        <div className="modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current">
                            <div className="modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md">
                                <h5
                                    className="text-xl font-medium leading-normal text-gray-800"
                                    id="exampleModalScrollableLabel"
                                >
                                    Add New Material
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
                                    name="material_title"
                                    type="text"
                                    value={data.title}
                                    autoComplete="material_title"
                                    isFocused={true}
                                    className="mt-5"
                                    handleChange={(e) =>
                                        setData("title", e.target.value)
                                    }
                                    required
                                >
                                    Material Title
                                </FloatingLabelInput>

                                <div class="flex justify-start mt-6">
                                    <div class="mb-3 w-96">
                                        <label
                                            for="formFile"
                                            class="form-label inline-block mb-2 text-gray-700"
                                        >
                                            Material File
                                        </label>
                                        <input
                                            class="form-control block w-full px-3 py-1.5 text-base font-normal text-gray-700 bg-white bg-clip-padding border border-solid border-gray-300 rounded transition ease-in-out m-0 focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none"
                                            type="file"
                                            required
                                            id="formFile"
                                            onChange={function (e) {
                                                setData(
                                                    "material",
                                                    e.target.files[0]
                                                );
                                            }}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className="modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md">
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
