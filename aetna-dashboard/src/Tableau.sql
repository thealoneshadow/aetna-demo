import React, { useState } from 'react';
import { ArrowLeftOnRectangleIcon, BoltIcon, ChatBubbleLeftIcon, ExclamationTriangleIcon, HandThumbDownIcon, HandThumbUpIcon, LinkIcon, MoonIcon, PaperAirplaneIcon, PencilSquareIcon, PlusIcon, TrashIcon, UserIcon } from "@heroicons/react/24/outline";
import Link from 'next/link';
import Image from 'next/image';
import "./styles.css"; // Import CSS file

const Home = () => {
    const [hasAnswered, setHasAnswered] = useState(false);

    return (
        <div className='container'>
            {/* Sidebar */}
            <div className='sidebar'>
                <div className='sidebar-content'>
                    <button className='new-chat-btn'>
                        <PlusIcon className='icon' />
                        New Chat
                    </button>
                    <div className='menu-section'>
                        <Link href="/home" className='menu-item'>
                            <ChatBubbleLeftIcon className='icon' />
                            <p>Translation Request</p>
                        </Link>
                    </div>
                    <div className='sidebar-footer'>
                        <Link href="/home" className='footer-item'>
                            <TrashIcon className='icon' />
                            <p>Clear conversations</p>
                        </Link>
                        <Link href="/home" className='footer-item'>
                            <UserIcon className='icon' />
                            <p>Upgrade to plus</p>
                        </Link>
                        <Link href="/home" className='footer-item'>
                            <MoonIcon className='icon' />
                            <p>Dark Mode</p>
                        </Link>
                        <Link href="/home" className='footer-item'>
                            <LinkIcon className='icon' />
                            <p>Updates</p>
                        </Link>
                        <Link href="/home" className='footer-item'>
                            <ArrowLeftOnRectangleIcon className='icon' />
                            <p>Logout</p>
                        </Link>
                    </div>
                </div>
            </div>

            {/* Chat Main Content */}
            <div className='chat-container'>
                {!hasAnswered && (
                    <div className='welcome-section'>
                        <h1 className='chat-title'>ChatGPT</h1>
                        <div className='info-grid'>
                            <div className='info-column'>
                                <SunIcon className='info-icon' />
                                <p>Examples</p>
                            </div>
                            <div className='info-column'>
                                <BoltIcon className='info-icon' />
                                <p>Capabilities</p>
                            </div>
                            <div className='info-column'>
                                <ExclamationTriangleIcon className='info-icon' />
                                <p>Limitations</p>
                            </div>
                        </div>
                        <div className='example-grid'>
                            <div className='example-item'>Explain quantum computing in simple terms</div>
                            <div className='example-item'>Remembers what user said earlier in the conversation</div>
                            <div className='example-item'>May occasionally generate incorrect information</div>
                        </div>
                    </div>
                )}

                {hasAnswered && (
                    <div className='chat-section'>
                        <div className='user-message'>
                            <div className='message-bubble'>
                                <div className='user-icon'>B</div>
                                <p>How does this work?</p>
                            </div>
                            <PencilSquareIcon className='edit-icon' />
                        </div>

                        <div className='ai-response'>
                            <div className='response-content'>
                                <div className='ai-logo'>
                                    <Image src="/logo.svg" fill alt='Open AI logo' />
                                </div>
                                <p>
                                    I'm assuming you're referring to how I work as a language model. As an AI language
                                    model, I was trained using vast amounts of data from the internet, books, and
                                    other sources...
                                </p>
                            </div>
                            <div className='response-actions'>
                                <HandThumbUpIcon className='icon' />
                                <HandThumbDownIcon className='icon' />
                            </div>
                        </div>
                    </div>
                )}

                {/* Input Box */}
                <div className='input-section'>
                    <input className='chat-input' placeholder='Type your message...' />
                    <PaperAirplaneIcon className='send-icon' onClick={() => setHasAnswered(true)} />
                </div>
            </div>
        </div>
    );
};

export default Home;





/* Global Styles */
.container {
    display: flex;
    height: 100vh;
    background-color: #ffffff;
    color: #000;
}

/* Sidebar */
.sidebar {
    width: 250px;
    background-color: #000;
    display: flex;
    flex-direction: column;
}

.sidebar-content {
    flex-grow: 1;
    padding: 20px;
}

.new-chat-btn {
    display: flex;
    align-items: center;
    padding: 10px;
    background: transparent;
    border: 1px solid gray;
    color: white;
    border-radius: 5px;
    cursor: pointer;
}

.new-chat-btn:hover {
    background: gray;
}

.menu-section {
    margin-top: 20px;
}

.menu-item {
    display: flex;
    align-items: center;
    padding: 10px;
    color: white;
    border-radius: 5px;
    text-decoration: none;
}

.menu-item:hover {
    background: rgba(255, 255, 255, 0.1);
}

.sidebar-footer {
    position: absolute;
    bottom: 20px;
    left: 20px;
    right: 20px;
    border-top: 1px solid gray;
    padding-top: 10px;
}

.footer-item {
    display: flex;
    align-items: center;
    padding: 8px;
    color: white;
    font-size: 14px;
    cursor: pointer;
}

.footer-item:hover {
    background: rgba(255, 255, 255, 0.1);
}

/* Chat Main Section */
.chat-container {
    flex: 1;
    display: flex;
    flex-direction: column;
    position: relative;
}

/* Welcome Section */
.welcome-section {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    flex-grow: 1;
}

.chat-title {
    font-size: 28px;
    font-weight: bold;
    margin-bottom: 20px;
}

.info-grid {
    display: flex;
    justify-content: center;
    gap: 30px;
}

.info-column {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.info-icon {
    width: 20px;
    height: 20px;
    margin-bottom: 5px;
}

.example-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 15px;
    justify-content: center;
    margin-top: 20px;
}

.example-item {
    padding: 10px;
    background: #f0f0f0;
    border-radius: 5px;
    cursor: pointer;
}

/* Chat Section */
.chat-section {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 20px;
}

.user-message {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-bottom: 10px;
}

.message-bubble {
    display: flex;
    align-items: center;
    background: #f5f5f5;
    padding: 10px;
    border-radius: 5px;
}

.user-icon {
    background: #4f46e5;
    color: white;
    padding: 8px;
    border-radius: 50%;
}

.ai-response {
    display: flex;
    justify-content: center;
    background: #e3f2fd;
    padding: 15px;
    border-radius: 5px;
}

.response-content {
    display: flex;
    align-items: center;
    gap: 10px;
}

.response-actions {
    display: flex;
    gap: 5px;
}

/* Input Section */
.input-section {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    width: 50%;
    display: flex;
    align-items: center;
    border: 1px solid gray;
    padding: 10px;
    border-radius: 5px;
}

.chat-input {
    flex: 1;
    border: none;
    padding: 10px;
}

.send-icon {
    cursor: pointer;
}

