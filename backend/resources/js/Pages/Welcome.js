import React from "react";
import { Link, Head } from "@inertiajs/inertia-react";
import ApplicationLogo from "@/Components/ApplicationLogo";
import { heroImage } from "@/images";

export default function Welcome(props) {
    const layoutStyle = {
        backgroundImage: "url('/images/bg-pattern.png')",
        backgroundSize: "cover",
    };
    return (
        <>
            <Head title="Welcome" />
            <div
                className="relative flex items-top justify-center min-h-screen bg-gray-100 dark:bg-gray-900 sm:items-center sm:pt-0"
                style={layoutStyle}
            >
                <div className="fixed top-0 left-0 flex w-full px-4 sm:px-6 lg:px-8 sm:block">
                    <div className="flex items-center justify-between">
                        <Link href="/">
                            <ApplicationLogo className="w-20 h-20 fill-current text-gray-500" />
                        </Link>
                        <div className="flex">
                            {props.auth.user ? (
                                <Link
                                    href={route("dashboard")}
                                    className="text-sm bg-primary text-white rounded-3xl hover:bg-primary-400"
                                >
                                    Dashboard
                                </Link>
                            ) : (
                                <>
                                    <Link
                                        href={route("login")}
                                        className="py-4 text-sm text-primary-600 hover:text-primary-400"
                                    >
                                        Log in
                                    </Link>

                                    <Link
                                        href={route("register")}
                                        className="py-4 px-8 ml-8 text-sm bg-primary text-white rounded-3xl hover:bg-primary-400"
                                    >
                                        Sign up
                                    </Link>
                                </>
                            )}
                        </div>
                    </div>
                </div>

                <div className="w-full mx-auto sm:px-6 xl:px-32 flex xl:flex-row flex-col items-center xl:justify-between justify-center xl:mt-0 mt-48">
                    <div className="flex flex-col">
                        <h1 className="text-8xl text-shadow-xl font-serif drop-shadow-xl text-primary">
                            Learnable
                        </h1>
                        <h2 className="text-2xl text-shadow-lg font-serif drop-shadow-xl mt-4">
                            Make learning easier and more practical
                        </h2>
                        <div className="flex mt-8 xl:px-0 xl:flex-row flex-col px-24">
                            <a
                                href="#"
                                className="bg-primary-600 text-white hover:bg-primary-400 px-8 py-4 rounded"
                            >
                                <i className="bx bxl-play-store"></i> Google
                                Play
                            </a>
                            <a
                                href="#"
                                className="bg-primary-600 text-white hover:bg-primary-400 px-8 py-4 rounded xl:ml-8 xl:mt-0 mt-4"
                            >
                                <i className="bx bxl-apple"></i> App Store
                            </a>
                        </div>
                    </div>
                    <img className="xl:mt-32 mt-16" src={heroImage} alt="Hero image" />
                </div>
            </div>
        </>
    );
}
