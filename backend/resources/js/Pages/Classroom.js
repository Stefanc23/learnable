import React, { useState } from "react";
import Authenticated from "@/Layouts/Authenticated";
import { Head, useForm, Link } from "@inertiajs/inertia-react";
import { thumbnailImage, avatarImage } from "@/images";
import "tw-elements";
import ValidationErrors from "@/Components/ValidationErrors";
import FloatingLabelInput from "@/Components/FloatingLabelInput";
import Button from "@/Components/Button";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faPlus } from "@fortawesome/free-solid-svg-icons";

export default function Classroom({ classroom, ...props }) {
    const [attendees, setAttendees] = useState(classroom.class_attendees);

    const { data, setData, post, progress, processing, errors, reset } =
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

    console.log(attendees);

    return (
        <Authenticated
            auth={props.auth}
            errors={props.errors}
            header={
                <div className="flex justify-between items-center">
                    <h2 className="font-semibold text-xl leading-tight">
                        {classroom.name}
                    </h2>
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
                        <li className="nav-item" role="presentation">
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
                        </li>
                    </ul>
                </div>
            }
        >
            <Head title={classroom.name} />

            <div className="max-w-7xl mx-auto py-10 sm:px-6 lg:px-8">
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
                                    <div class="overflow-hidden">
                                        <table class="min-w-full text-left">
                                            <thead class="border-b bg-primary-800 text-start">
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
                                                {attendees.map(
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
                        Assignemnt
                    </div>
                    <div
                        class="tab-pane fade"
                        id="tabs-material"
                        role="tabpanel"
                        aria-labelledby="tabs-material-tab"
                    >
                        Material
                    </div>
                    <div
                        className="tab-pane fade"
                        id="tabs-forum"
                        role="tabpanel"
                        aria-labelledby="tabs-forum-tab"
                    >
                        Forum
                    </div>
                </div>
            </div>
        </Authenticated>
    );
}
