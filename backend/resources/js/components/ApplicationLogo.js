import React from "react";
import { logoSVG } from "@/images";

export default function ApplicationLogo({ className }) {
    return <img className={className} src={logoSVG} />;
}
