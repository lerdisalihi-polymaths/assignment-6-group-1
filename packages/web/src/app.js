// API configuration
// Use environment variable or default to same-origin /api endpoint
const API_URL = window.API_URL || (
    window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1'
        ? 'http://localhost:5000/api'
        : `${window.location.protocol}//${window.location.hostname}/api`
);

let currentFilter = 'all';

// DOM Elements
const taskForm = document.getElementById('taskForm');
const editTaskForm = document.getElementById('editTaskForm');
const tasksList = document.getElementById('tasksList');
const modal = document.getElementById('editModal');
const closeModal = document.querySelector('.close');
const filterButtons = document.querySelectorAll('.filter-btn');

// Event Listeners
taskForm.addEventListener('submit', handleAddTask);
editTaskForm.addEventListener('submit', handleEditTask);
closeModal.addEventListener('click', () => modal.style.display = 'none');
window.addEventListener('click', (e) => {
    if (e.target === modal) modal.style.display = 'none';
});

filterButtons.forEach(btn => {
    btn.addEventListener('click', (e) => {
        filterButtons.forEach(b => b.classList.remove('active'));
        e.target.classList.add('active');
        currentFilter = e.target.dataset.filter;
        loadTasks();
    });
});

// Load tasks on page load
loadTasks();

// Functions
async function loadTasks() {
    try {
        const response = await fetch(`${API_URL}/tasks`);
        if (!response.ok) throw new Error('Failed to fetch tasks');
        
        const tasks = await response.json();
        displayTasks(tasks);
    } catch (error) {
        console.error('Error loading tasks:', error);
        showError('Failed to load tasks. Please check if the API is running.');
    }
}

function displayTasks(tasks) {
    // Filter tasks
    const filteredTasks = currentFilter === 'all' 
        ? tasks 
        : tasks.filter(task => task.status === currentFilter);

    if (filteredTasks.length === 0) {
        tasksList.innerHTML = `
            <div class="empty-state">
                <p>No ${currentFilter === 'all' ? '' : currentFilter} tasks found.</p>
                <p>Add a new task to get started!</p>
            </div>
        `;
        return;
    }

    tasksList.innerHTML = filteredTasks.map(task => `
        <div class="task-item ${task.status}" data-id="${task.id}">
            <div class="task-header">
                <h3 class="task-title">${escapeHtml(task.title)}</h3>
                <span class="task-status ${task.status}">${task.status}</span>
            </div>
            ${task.description ? `<p class="task-description">${escapeHtml(task.description)}</p>` : ''}
            <div class="task-meta">Created: ${formatDate(task.created_at)}</div>
            <div class="task-actions">
                <button class="edit-btn" onclick="openEditModal(${task.id})">Edit</button>
                <button class="delete-btn" onclick="deleteTask(${task.id})">Delete</button>
            </div>
        </div>
    `).join('');
}

async function handleAddTask(e) {
    e.preventDefault();
    
    const taskData = {
        title: document.getElementById('taskTitle').value,
        description: document.getElementById('taskDescription').value,
        status: document.getElementById('taskStatus').value
    };

    try {
        const response = await fetch(`${API_URL}/tasks`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(taskData)
        });

        if (!response.ok) throw new Error('Failed to create task');

        taskForm.reset();
        loadTasks();
        showSuccess('Task created successfully!');
    } catch (error) {
        console.error('Error creating task:', error);
        showError('Failed to create task');
    }
}

async function openEditModal(taskId) {
    try {
        const response = await fetch(`${API_URL}/tasks/${taskId}`);
        if (!response.ok) throw new Error('Failed to fetch task');
        
        const task = await response.json();
        
        document.getElementById('editTaskId').value = task.id;
        document.getElementById('editTaskTitle').value = task.title;
        document.getElementById('editTaskDescription').value = task.description;
        document.getElementById('editTaskStatus').value = task.status;
        
        modal.style.display = 'block';
    } catch (error) {
        console.error('Error loading task:', error);
        showError('Failed to load task');
    }
}

async function handleEditTask(e) {
    e.preventDefault();
    
    const taskId = document.getElementById('editTaskId').value;
    const taskData = {
        title: document.getElementById('editTaskTitle').value,
        description: document.getElementById('editTaskDescription').value,
        status: document.getElementById('editTaskStatus').value
    };

    try {
        const response = await fetch(`${API_URL}/tasks/${taskId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(taskData)
        });

        if (!response.ok) throw new Error('Failed to update task');

        modal.style.display = 'none';
        loadTasks();
        showSuccess('Task updated successfully!');
    } catch (error) {
        console.error('Error updating task:', error);
        showError('Failed to update task');
    }
}

async function deleteTask(taskId) {
    if (!confirm('Are you sure you want to delete this task?')) return;

    try {
        const response = await fetch(`${API_URL}/tasks/${taskId}`, {
            method: 'DELETE'
        });

        if (!response.ok) throw new Error('Failed to delete task');

        loadTasks();
        showSuccess('Task deleted successfully!');
    } catch (error) {
        console.error('Error deleting task:', error);
        showError('Failed to delete task');
    }
}

// Utility functions
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString() + ' ' + date.toLocaleTimeString();
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function showSuccess(message) {
    // Simple alert for now - you can replace with a toast notification
    alert(message);
}

function showError(message) {
    alert('Error: ' + message);
}
