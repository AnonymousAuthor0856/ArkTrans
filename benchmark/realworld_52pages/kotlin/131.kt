
package com.example.todoapp

import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInHorizontally
import androidx.compose.animation.slideOutHorizontally
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.staggeredgrid.LazyVerticalStaggeredGrid
import androidx.compose.foundation.lazy.staggeredgrid.StaggeredGridCells
import androidx.compose.foundation.lazy.staggeredgrid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.MoreVert
import androidx.compose.material.icons.filled.Save
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.outlined.Inbox
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.material3.SwipeToDismissBox
import androidx.compose.material3.SwipeToDismissBoxValue
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberSwipeToDismissBoxState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch


private enum class Priority { High, Medium, Low }

private data class TodoItem(
    val id: Int,
    val title: String,
    val priority: Priority,
    val description: String
)


private enum class Screen { List, Add, Update }


private val priorityColor = mapOf(
    Priority.High to Color(0xFFFF4646),
    Priority.Medium to Color(0xFFFFC114),
    Priority.Low to Color(0xFF00C980)
)

private val priorityLabel = mapOf(
    Priority.High to "High Priority",
    Priority.Medium to "Medium Priority",
    Priority.Low to "Low Priority"
)

private val mockData = listOf(
    TodoItem(1, "Buy groceries", Priority.High, "Milk, eggs, bread, and vegetables for the week"),
    TodoItem(2, "Finish report", Priority.High, "Complete the quarterly report for the team meeting"),
    TodoItem(3, "Call dentist", Priority.Medium, "Schedule a checkup appointment for next month"),
    TodoItem(4, "Read a book", Priority.Low, "Finish reading Clean Code by Robert C. Martin"),
    TodoItem(5, "Plan weekend trip", Priority.Medium, "Research hotels and activities for the getaway"),
    TodoItem(6, "Organize desk", Priority.Low, "Clean and organize the home office workspace")
)


private enum class SortOrder { None, HighFirst, LowFirst }

private data class AppState(
    val currentScreen: Screen = Screen.List,
    val todoList: List<TodoItem> = mockData,
    val searchQuery: String = "",
    val isSearchVisible: Boolean = false,
    val sortOrder: SortOrder = SortOrder.None,
    val showDeleteAllDialog: Boolean = false,
    val snackbarDeletedItem: TodoItem? = null,
    val addTitle: String = "",
    val addPriority: Priority = Priority.Low,
    val addDescription: String = "",
    val addValidationError: Boolean = false,
    val updateItem: TodoItem? = null,
    val updateTitle: String = "",
    val updatePriority: Priority = Priority.Low,
    val updateDescription: String = "",
    val updateValidationError: Boolean = false,
    val showDeleteConfirmDialog: Boolean = false
)





@Composable
private fun ListScreen(
    state: AppState,
    onNavigateToAdd: () -> Unit,
    onNavigateToUpdate: (TodoItem) -> Unit,
    onDeleteItem: (TodoItem) -> Unit,
    onUndoDelete: (TodoItem) -> Unit,
    onDismissSnackbar: () -> Unit,
    onDeleteAll: () -> Unit,
    onSearchQueryChange: (String) -> Unit,
    onToggleSearch: () -> Unit,
    onSortOrderChange: (SortOrder) -> Unit,
    onShowDeleteAllDialog: () -> Unit,
    onDismissDeleteAllDialog: () -> Unit
) {
    val snackbarHostState = remember { SnackbarHostState() }
    val scope = rememberCoroutineScope()
    var showSortMenu by remember { mutableStateOf(false) }

    var debouncedQuery by remember { mutableStateOf("") }
    LaunchedEffect(state.searchQuery) {
        delay(500)
        debouncedQuery = state.searchQuery
    }

    val displayItems = state.todoList
        .filter { item ->
            debouncedQuery.isBlank() ||
                    item.title.contains(debouncedQuery, ignoreCase = true) ||
                    item.description.contains(debouncedQuery, ignoreCase = true)
        }
        .let { list ->
            when (state.sortOrder) {
                SortOrder.HighFirst -> list.sortedBy { it.priority.ordinal }
                SortOrder.LowFirst -> list.sortedByDescending { it.priority.ordinal }
                SortOrder.None -> list
            }
        }

    LaunchedEffect(state.snackbarDeletedItem) {
        state.snackbarDeletedItem?.let { deleted ->
            val result = snackbarHostState.showSnackbar(
                message = "Deleted '${deleted.title}'",
                actionLabel = "Undo"
            )
            if (result == SnackbarResult.ActionPerformed) {
                onUndoDelete(deleted)
            } else {
                onDismissSnackbar()
            }
        }
    }

    if (state.showDeleteAllDialog) {
        AlertDialog(
            onDismissRequest = onDismissDeleteAllDialog,
            title = { Text("Delete Everything?") },
            text = { Text("Are you sure you want to remove: Everything?") },
            confirmButton = {
                TextButton(onClick = onDeleteAll) {
                    Text("YES")
                }
            },
            dismissButton = {
                TextButton(onClick = onDismissDeleteAllDialog) {
                    Text("NO")
                }
            }
        )
    }

    Scaffold(
        snackbarHost = { SnackbarHost(snackbarHostState) },
        topBar = {
            if (state.isSearchVisible) {
                TopAppBar(
                    title = {
                        OutlinedTextField(
                            value = state.searchQuery,
                            onValueChange = onSearchQueryChange,
                            placeholder = { Text("Search") },
                            singleLine = true,
                            modifier = Modifier.fillMaxWidth()
                        )
                    },
                    navigationIcon = {
                        IconButton(onClick = onToggleSearch) {
                            Icon(Icons.Default.ArrowBack, contentDescription = "Close search")
                        }
                    },
                    colors = TopAppBarDefaults.topAppBarColors(
                        containerColor = MaterialTheme.colorScheme.primary,
                        titleContentColor = MaterialTheme.colorScheme.onPrimary,
                        navigationIconContentColor = MaterialTheme.colorScheme.onPrimary
                    )
                )
            } else {
                TopAppBar(
                    title = { Text("ToDo List") },
                    actions = {
                        IconButton(onClick = onToggleSearch) {
                            Icon(Icons.Default.Search, contentDescription = "Search")
                        }
                        Box {
                            IconButton(onClick = { showSortMenu = true }) {
                                Icon(Icons.Default.MoreVert, contentDescription = "Sort / Delete")
                            }
                            DropdownMenu(
                                expanded = showSortMenu,
                                onDismissRequest = { showSortMenu = false }
                            ) {
                                DropdownMenuItem(
                                    text = { Text("Priority High") },
                                    onClick = {
                                        onSortOrderChange(SortOrder.HighFirst)
                                        showSortMenu = false
                                    }
                                )
                                DropdownMenuItem(
                                    text = { Text("Priority Low") },
                                    onClick = {
                                        onSortOrderChange(SortOrder.LowFirst)
                                        showSortMenu = false
                                    }
                                )
                                HorizontalDivider()
                                DropdownMenuItem(
                                    text = {
                                        Text(
                                            "Delete All",
                                            color = MaterialTheme.colorScheme.error
                                        )
                                    },
                                    onClick = {
                                        showSortMenu = false
                                        onShowDeleteAllDialog()
                                    }
                                )
                            }
                        }
                    },
                    colors = TopAppBarDefaults.topAppBarColors(
                        containerColor = MaterialTheme.colorScheme.primary,
                        titleContentColor = MaterialTheme.colorScheme.onPrimary,
                        actionIconContentColor = MaterialTheme.colorScheme.onPrimary
                    )
                )
            }
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = onNavigateToAdd,
                containerColor = MaterialTheme.colorScheme.primary
            ) {
                Icon(Icons.Default.Add, contentDescription = "Add")
            }
        }
    ) { padding ->
        if (displayItems.isEmpty()) {
            EmptyState(modifier = Modifier.padding(padding))
        } else {
            LazyVerticalStaggeredGrid(
                columns = StaggeredGridCells.Fixed(2),
                contentPadding = PaddingValues(
                    start = 8.dp,
                    end = 8.dp,
                    top = padding.calculateTopPadding() + 8.dp,
                    bottom = padding.calculateBottomPadding() + 80.dp
                ),
                modifier = Modifier.fillMaxSize()
            ) {
                items(displayItems, key = { it.id }) { item ->
                    SwipeableTodoCard(
                        item = item,
                        onClick = { onNavigateToUpdate(item) },
                        onSwipeDelete = { onDeleteItem(item) }
                    )
                }
            }
        }
    }
}


@Composable
private fun AddScreen(
    state: AppState,
    onNavigateBack: () -> Unit,
    onTitleChange: (String) -> Unit,
    onPriorityChange: (Priority) -> Unit,
    onDescriptionChange: (String) -> Unit,
    onSave: () -> Unit
) {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Add ToDo") },
                navigationIcon = {
                    IconButton(onClick = onNavigateBack) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                    }
                },
                actions = {
                    IconButton(onClick = onSave) {
                        Icon(Icons.Default.Check, contentDescription = "Save")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary,
                    navigationIconContentColor = MaterialTheme.colorScheme.onPrimary,
                    actionIconContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(24.dp)
        ) {
            OutlinedTextField(
                value = state.addTitle,
                onValueChange = onTitleChange,
                label = { Text("Title") },
                singleLine = true,
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(modifier = Modifier.height(8.dp))

            PriorityDropdown(
                selectedPriority = state.addPriority,
                onPrioritySelected = onPriorityChange,
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(modifier = Modifier.height(8.dp))

            OutlinedTextField(
                value = state.addDescription,
                onValueChange = onDescriptionChange,
                label = { Text("Description") },
                minLines = 3,
                maxLines = 10,
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
            )

            if (state.addValidationError) {
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = "Please fill out all the fields.",
                    color = MaterialTheme.colorScheme.error,
                    style = MaterialTheme.typography.bodyMedium
                )
            }
        }
    }
}

@Composable
private fun UpdateScreen(
    state: AppState,
    onNavigateBack: () -> Unit,
    onTitleChange: (String) -> Unit,
    onPriorityChange: (Priority) -> Unit,
    onDescriptionChange: (String) -> Unit,
    onSave: () -> Unit,
    onDelete: () -> Unit,
    onShowDeleteDialog: () -> Unit,
    onDismissDeleteDialog: () -> Unit
) {
    val item = state.updateItem ?: return

    if (state.showDeleteConfirmDialog) {
        AlertDialog(
            onDismissRequest = onDismissDeleteDialog,
            title = { Text("Delete '${item.title}'?") },
            text = { Text("Are you sure you want to remove: '${item.title}'?") },
            confirmButton = {
                TextButton(onClick = onDelete) {
                    Text("YES")
                }
            },
            dismissButton = {
                TextButton(onClick = onDismissDeleteDialog) {
                    Text("NO")
                }
            }
        )
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Update ToDo") },
                navigationIcon = {
                    IconButton(onClick = onNavigateBack) {
                        Icon(Icons.Default.ArrowBack, contentDescription = "Back")
                    }
                },
                actions = {
                    IconButton(onClick = onSave) {
                        Icon(Icons.Default.Save, contentDescription = "Save")
                    }
                    IconButton(onClick = onShowDeleteDialog) {
                        Icon(Icons.Default.Delete, contentDescription = "Delete")
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = MaterialTheme.colorScheme.onPrimary,
                    navigationIconContentColor = MaterialTheme.colorScheme.onPrimary,
                    actionIconContentColor = MaterialTheme.colorScheme.onPrimary
                )
            )
        }
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(24.dp)
        ) {
            OutlinedTextField(
                value = state.updateTitle,
                onValueChange = onTitleChange,
                label = { Text("Title") },
                singleLine = true,
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(modifier = Modifier.height(8.dp))

            PriorityDropdown(
                selectedPriority = state.updatePriority,
                onPrioritySelected = onPriorityChange,
                modifier = Modifier.fillMaxWidth()
            )

            Spacer(modifier = Modifier.height(8.dp))

            OutlinedTextField(
                value = state.updateDescription,
                onValueChange = onDescriptionChange,
                label = { Text("Description") },
                minLines = 3,
                maxLines = 10,
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(1f)
            )

            if (state.updateValidationError) {
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = "Please fill out all the fields.",
                    color = MaterialTheme.colorScheme.error,
                    style = MaterialTheme.typography.bodyMedium
                )
            }
        }
    }
}


@Composable
private fun SwipeableTodoCard(
    item: TodoItem,
    onClick: () -> Unit,
    onSwipeDelete: () -> Unit
) {
    val dismissState = rememberSwipeToDismissBoxState(
        confirmValueChange = { value ->
            if (value == SwipeToDismissBoxValue.EndToStart) {
                onSwipeDelete()
                true
            } else false
        }
    )

    SwipeToDismissBox(
        state = dismissState,
        backgroundContent = {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(4.dp)
                    .clip(RoundedCornerShape(12.dp))
                    .background(Color.Red.copy(alpha = 0.85f)),
                contentAlignment = Alignment.CenterEnd
            ) {
                Icon(
                    Icons.Default.Delete,
                    contentDescription = "Delete",
                    tint = Color.White,
                    modifier = Modifier.padding(end = 20.dp)
                )
            }
        },
        enableDismissFromStartToEnd = false,
        enableDismissFromEndToStart = true
    ) {
        TodoCard(item = item, onClick = onClick)
    }
}

@Composable
private fun TodoCard(
    item: TodoItem,
    onClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(4.dp)
            .clickable { onClick() },
        shape = RoundedCornerShape(12.dp),
        elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
    ) {
        Box(modifier = Modifier.fillMaxWidth()) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(start = 16.dp, end = 40.dp, top = 16.dp, bottom = 16.dp)
            ) {
                Text(
                    text = item.title,
                    fontWeight = FontWeight.Bold,
                    fontSize = 20.sp,
                    color = MaterialTheme.colorScheme.onSurface
                )
                if (item.description.isNotBlank()) {
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(
                        text = item.description,
                        fontSize = 14.sp,
                        color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.6f)
                    )
                }
            }

            Box(
                modifier = Modifier
                    .align(Alignment.TopEnd)
                    .padding(top = 16.dp, end = 16.dp)
                    .size(16.dp)
                    .clip(CircleShape)
                    .background(priorityColor[item.priority] ?: Color.Gray)
            )
        }
    }
}

@Composable
private fun PriorityDropdown(
    selectedPriority: Priority,
    onPrioritySelected: (Priority) -> Unit,
    modifier: Modifier = Modifier
) {
    var expanded by remember { mutableStateOf(false) }
    val priorities = listOf(Priority.High, Priority.Medium, Priority.Low)

    ExposedDropdownMenuBox(
        expanded = expanded,
        onExpandedChange = { expanded = !expanded },
        modifier = modifier
    ) {
        OutlinedTextField(
            value = priorityLabel[selectedPriority] ?: "",
            onValueChange = {},
            readOnly = true,
            trailingIcon = { ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded) },
            modifier = Modifier
                .fillMaxWidth()
                .menuAnchor()
        )
        ExposedDropdownMenu(
            expanded = expanded,
            onDismissRequest = { expanded = false }
        ) {
            priorities.forEach { priority ->
                DropdownMenuItem(
                    text = { Text(priorityLabel[priority] ?: "") },
                    onClick = {
                        onPrioritySelected(priority)
                        expanded = false
                    }
                )
            }
        }
    }
}

@Composable
private fun EmptyState(modifier: Modifier = Modifier) {
    Column(
        modifier = modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Icon(
            imageVector = Icons.Outlined.Inbox,
            contentDescription = null,
            modifier = Modifier.size(100.dp),
            tint = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.4f)
        )
        Spacer(modifier = Modifier.height(12.dp))
        Text(
            text = "No Data",
            fontSize = 16.sp,
            color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.5f)
        )
    }
}


@Preview(name = "Add Screen", showBackground = true)
@Composable
private fun AddScreenPreview() {
    MaterialTheme {
        AddScreen(
            state = AppState(),
            onNavigateBack = {},
            onTitleChange = {},
            onPriorityChange = {},
            onDescriptionChange = {},
            onSave = {}
        )
    }
}

