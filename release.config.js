// release.config.js
module.exports = {
    branches: [
        {name: 'main', prerelease: false},
        {name: 'beta', prerelease: true},
    ],
    plugins: [
        "@semantic-release/commit-analyzer",
        "@semantic-release/release-notes-generator",
        ["@semantic-release/gitlab", {
            "assets": [
                { "path": "build/ow2re.txt", "label": " Remastered Overwatch " },
                { "path": "build/ow2dev.txt", "label": " Overwatch Developer Build" },
            ]
        }], 
        ["semantic-release-discord-bot", {
            "notifications": [
                { "branch": "*" },
            ]
        }]
    ],
};
