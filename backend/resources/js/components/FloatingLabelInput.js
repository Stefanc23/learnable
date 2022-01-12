import React, { useState, useEffect, useRef } from "react";

export default function FloatingLabelInput({
    type,
    name,
    value,
    required,
    handleChange,
    autoComplete,
    isFocused,
    className,
    children,
    disabled
}) {
    const [active, setActive] = useState(false);
    const input = useRef();

    useEffect(() => {
        if (isFocused) {
            input.current.focus();
        }

        if (value != '' && value != null || type == 'date') {
            setActive(true);
        }
    }, []);

    function handleActivation(e) {
        setActive(!!e.target.value);
        handleChange(e);
    }

    return (
        <div
            className={`relative border rounded bg-white text-primary border-primary border-opacity-25 ${className}`}
        >
            <input
                className={[
                    "outline-none w-full rounded bg-transparent transition-all duration-200 ease-in-out p-2",
                    active ? "pt-6" : "",
                ].join(" ")}
                id={name}
                name={name}
                type={type}
                value={value}
                ref={input}
                autoComplete={autoComplete}
                required={required}
                disabled={disabled}
                onChange={(e) => handleActivation(e)}
            />
            <label
                className={[
                    "absolute top-0 left-0 flex items-center text-primary p-2 transition-all duration-200 ease-in-out",
                    active ? "text-xs" : "",
                ].join(" ")}
                htmlFor={name}
            >
                {children}
            </label>
        </div>
    );
}
