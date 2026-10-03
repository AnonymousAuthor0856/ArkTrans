/*
 * HomeActivity - Single-file Compose UI with all components embedded inline.
 * Replaces XML layouts, Fragments, and Data Binding for the home screen.
 */

package com.maltaisn.notes.ui.home

import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.KeyEvent
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.animation.AnimatedVisibility
import androidx.fragment.app.FragmentActivity
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.combinedClickable
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
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.staggeredgrid.LazyVerticalStaggeredGrid
import androidx.compose.foundation.lazy.staggeredgrid.StaggeredGridCells
import androidx.compose.foundation.lazy.staggeredgrid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.automirrored.filled.Sort
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Archive
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.ContentCopy
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Label
import androidx.compose.material.icons.filled.Menu
import androidx.compose.material.icons.filled.MoreVert
import androidx.compose.material.icons.filled.PushPin
import androidx.compose.material.icons.filled.Search
import androidx.compose.material.icons.filled.Share
import androidx.compose.material.icons.outlined.Alarm
import androidx.compose.material.icons.outlined.Delete
import androidx.compose.material.icons.outlined.GridView
import androidx.compose.material.icons.outlined.Label
import androidx.compose.material.icons.outlined.ListAlt
import androidx.compose.material.icons.outlined.Notifications
import androidx.compose.material.icons.outlined.Settings
import androidx.compose.material.icons.outlined.ViewList
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Checkbox
import androidx.compose.material3.DrawerValue
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.ModalDrawerSheet
import androidx.compose.material3.ModalNavigationDrawer
import androidx.compose.material3.NavigationDrawerItem
import androidx.compose.material3.NavigationDrawerItemDefaults
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.material3.rememberDrawerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.livedata.observeAsState
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.input.key.Key
import androidx.compose.ui.input.key.key
import androidx.compose.ui.input.key.onKeyEvent
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import com.maltaisn.notes.model.PrefsManager
import com.maltaisn.notes.model.entity.Label
import com.maltaisn.notes.model.entity.Note
import com.maltaisn.notes.model.entity.NoteStatus
import com.maltaisn.notes.model.entity.NoteType
import com.maltaisn.notes.ui.EXTRA_NOTE_CONTENT
import com.maltaisn.notes.ui.EXTRA_NOTE_ID
import com.maltaisn.notes.ui.EXTRA_NOTE_TITLE
import com.maltaisn.notes.ui.EXTRA_NOTE_TYPE
import com.maltaisn.notes.ui.NavigationHost
import com.maltaisn.notes.ui.SharedViewModel
import com.maltaisn.notes.ui.edit.EditActivity
import com.maltaisn.notes.ui.labels.LabelActivity
import com.maltaisn.notes.ui.navigation.HomeDestination
import com.maltaisn.notes.ui.note.adapter.NoteListItem
import com.maltaisn.notes.ui.observeEvent
import com.maltaisn.notes.ui.settings.SettingsActivity
import dagger.hilt.android.AndroidEntryPoint
import kotlinx.coroutines.launch
import javax.inject.Inject

private const val NAME = "NotesApp_HomeActivity"
private const val UI_TYPE = "Notes"
private const val STYLE_THEME = "Material3"
private const val LANG = "en"
private const val BASELINE_SIZE = "360x640"

object AppTokens {
    object Colors {
        val primary = Color(0xFF1E6D3B)
        val onPrimary = Color(0xFFFFFFFF)
        val primaryContainer = Color(0xFFD7F5D9)
        val onPrimaryContainer = Color(0xFF00210A)
        val secondary = Color(0xFF516351)
        val onSecondary = Color(0xFFFFFFFF)
        val secondaryContainer = Color(0xFFD4E8D3)
        val onSecondaryContainer = Color(0xFF0F1F12)
        val tertiary = Color(0xFF3A656F)
        val onTertiary = Color(0xFFFFFFFF)
        val tertiaryContainer = Color(0xFFBDEAF6)
        val onTertiaryContainer = Color(0xFF001F26)
        val error = Color(0xFFBA1A1A)
        val onError = Color(0xFFFFFFFF)
        val errorContainer = Color(0xFFFFDAD6)
        val onErrorContainer = Color(0xFF410002)
        val background = Color(0xFFF8FBF1)
        val onBackground = Color(0xFF191D19)
        val surface = Color(0xFFF8FBF1)
        val onSurface = Color(0xFF191D19)
        val surfaceVariant = Color(0xFFDDE5DA)
        val onSurfaceVariant = Color(0xFF424940)
        val outline = Color(0xFF727970)
        val outlineVariant = Color(0xFFC1C9BE)
        val inverseSurface = Color(0xFF2E322E)
        val inverseOnSurface = Color(0xFFEFF3E9)
        val inversePrimary = Color(0xFF80D786)
        val surfaceTint = Color(0xFF1E6D3B)
        val surfaceDim = Color(0xFFD8DCD3)
        val surfaceBright = Color(0xFFF8FBF1)
        val surfaceContainerLowest = Color(0xFFFFFFFF)
        val surfaceContainerLow = Color(0xFFF2F6EC)
        val surfaceContainer = Color(0xFFECF0E6)
        val surfaceContainerHigh = Color(0xFFE7EAE0)
        val surfaceContainerHighest = Color(0xFFE1E4DB)
        val warning = Color(0xFFF59E0B)
        val success = Color(0xFF16A34A)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
        val caption = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Normal)
    }

    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(16.dp)
        val extraLarge = RoundedCornerShape(24.dp)
    }

    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 36.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)

    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(8.dp, 12.dp, 6.dp, 0.16f)
    }
}


private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    primaryContainer = AppTokens.Colors.primaryContainer,
    onPrimaryContainer = AppTokens.Colors.onPrimaryContainer,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    secondaryContainer = AppTokens.Colors.secondaryContainer,
    onSecondaryContainer = AppTokens.Colors.onSecondaryContainer,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    tertiaryContainer = AppTokens.Colors.tertiaryContainer,
    onTertiaryContainer = AppTokens.Colors.onTertiaryContainer,
    error = AppTokens.Colors.error,
    onError = AppTokens.Colors.onError,
    errorContainer = AppTokens.Colors.errorContainer,
    onErrorContainer = AppTokens.Colors.onErrorContainer,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    onSurfaceVariant = AppTokens.Colors.onSurfaceVariant,
    outline = AppTokens.Colors.outline,
    outlineVariant = AppTokens.Colors.outlineVariant,
    inverseSurface = AppTokens.Colors.inverseSurface,
    inverseOnSurface = AppTokens.Colors.inverseOnSurface,
    inversePrimary = AppTokens.Colors.inversePrimary,
    surfaceTint = AppTokens.Colors.surfaceTint,
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label,
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.extraLarge,
        ),
        content = content
    )
}

enum class DrawerDestination(val title: String, val icon: ImageVector) {
    NOTES("Notes", Icons.Outlined.ListAlt),
    REMINDERS("Reminders", Icons.Outlined.Notifications),
    ARCHIVE("Archive", Icons.Filled.Archive),
    TRASH("Trash", Icons.Outlined.Delete),
    SETTINGS("Settings", Icons.Outlined.Settings),
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen(
    homeViewModel: HomeViewModel,
    mainViewModel: HomeMainViewModel,
    sharedViewModel: SharedViewModel,
    prefs: PrefsManager,
    onNavigateToEdit: (noteId: Long) -> Unit,
    onNavigateToSettings: () -> Unit,
    onNavigateToLabels: () -> Unit,
    onCreateNote: () -> Unit,
) {
    val drawerState = rememberDrawerState(DrawerValue.Closed)
    val scope = rememberCoroutineScope()
    val homeDestination by mainViewModel.currentHomeDestination.observeAsState(
        HomeDestination.Status(NoteStatus.ACTIVE)
    )
    var searchQuery by remember { mutableStateOf("") }
    var isSearchActive by remember { mutableStateOf(false) }
    var isGridMode by remember { mutableStateOf(false) }

    val selection by homeViewModel.currentSelection.observeAsState(
        com.maltaisn.notes.ui.note.NoteViewModel.NoteSelection(0, null, com.maltaisn.notes.model.entity.PinnedStatus.CANT_PIN, false)
    )
    val isSelectionMode = selection.count > 0

    ModalNavigationDrawer(
        drawerState = drawerState,
        drawerContent = {
            ModalDrawerSheet(
                modifier = Modifier.width(320.dp),
                drawerContainerColor = AppTokens.Colors.surface,
            ) {
                NavigationDrawerContent(
                    appName = "Notes",
                    homeDestination = homeDestination,
                    onDestinationSelected = { dest ->
                        handleDrawerNavigation(dest, mainViewModel, onNavigateToSettings)
                        scope.launch { drawerState.close() }
                    },
                    onManageLabels = {
                        onNavigateToLabels()
                        scope.launch { drawerState.close() }
                    },
                    onCreateLabel = {
                        scope.launch { drawerState.close() }
                    },
                )
            }
        },
        gesturesEnabled = !isSelectionMode && !isSearchActive,
    ) {
        Scaffold(
            containerColor = AppTokens.Colors.background,
            topBar = {
                if (isSelectionMode) {
                    SelectionTopBar(
                        count = selection.count,
                        status = selection.status,
                        pinned = selection.pinned,
                        hasReminder = selection.hasReminder,
                        onClose = { homeViewModel.clearSelection() },
                        onPin = { homeViewModel.togglePin() },
                        onReminder = { homeViewModel.createReminder() },
                        onLabels = { homeViewModel.changeLabels() },
                        onMove = { homeViewModel.moveSelectedNotes() },
                        onDelete = { homeViewModel.deleteSelectedNotesPre() },
                        onShare = { homeViewModel.shareSelectedNote() },
                        onCopy = { homeViewModel.copySelectedNote("Untitled", "(copy)") },
                        onSelectAll = { homeViewModel.selectAll() },
                    )
                } else if (isSearchActive) {
                    SearchTopBar(
                        query = searchQuery,
                        onQueryChange = { searchQuery = it },
                        onClose = {
                            isSearchActive = false
                            searchQuery = ""
                        },
                    )
                } else {
                    HomeTopBar(
                        title = homeDestination.title(),
                        onMenuClick = { scope.launch { drawerState.open() } },
                        onSearchClick = { isSearchActive = true },
                        onSortClick = { /* show sort dialog */ },
                        isGridMode = isGridMode,
                        onToggleLayout = { isGridMode = !isGridMode },
                    )
                }
            },
            floatingActionButton = {
                if (!isSelectionMode && !isSearchActive) {
                    FloatingActionButton(
                        onClick = onCreateNote,
                        containerColor = AppTokens.Colors.primaryContainer,
                        contentColor = AppTokens.Colors.onPrimaryContainer,
                        shape = AppTokens.Shapes.large,
                    ) {
                        Icon(Icons.Filled.Add, contentDescription = "Create Note")
                    }
                }
            },
            bottomBar = {
                if (isSelectionMode) {
                    SelectionBottomBar(
                        count = selection.count,
                        onClose = { homeViewModel.clearSelection() },
                    )
                }
            },
        ) { padding ->
            Box(modifier = Modifier.padding(padding)) {
                NotesList(
                    homeViewModel = homeViewModel,
                    isGridMode = isGridMode,
                    isSelectionMode = isSelectionMode,
                    onNoteClick = { noteItem, position ->
                        if (isSelectionMode) {
                            homeViewModel.onNoteItemClicked(noteItem, position)
                        } else {
                            onNavigateToEdit(noteItem.note.id)
                        }
                    },
                    onNoteLongClick = { noteItem, position ->
                        homeViewModel.onNoteItemLongClicked(noteItem, position)
                    },
                )
            }
        }
    }
}

@Composable
fun NavigationDrawerContent(
    appName: String,
    homeDestination: HomeDestination,
    onDestinationSelected: (DrawerDestination) -> Unit,
    onManageLabels: () -> Unit,
    onCreateLabel: () -> Unit,
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(AppTokens.Colors.surface)
    ) {

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .padding(AppTokens.Spacing.xl),
            contentAlignment = Alignment.CenterStart,
        ) {
            Text(
                appName,
                style = MaterialTheme.typography.headlineMedium,
                color = AppTokens.Colors.onSurface,
            )
        }

        HorizontalDivider(color = AppTokens.Colors.outlineVariant)

        Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))


        NavigationDrawerItem(
            icon = { Icon(DrawerDestination.NOTES.icon, contentDescription = null) },
            label = { Text(DrawerDestination.NOTES.title) },
            selected = homeDestination is HomeDestination.Status && homeDestination.status == NoteStatus.ACTIVE,
            onClick = { onDestinationSelected(DrawerDestination.NOTES) },
            colors = NavigationDrawerItemDefaults.colors(
                selectedIconColor = AppTokens.Colors.primary,
                selectedTextColor = AppTokens.Colors.primary,
                selectedContainerColor = AppTokens.Colors.primaryContainer,
                unselectedIconColor = AppTokens.Colors.onSurfaceVariant,
                unselectedTextColor = AppTokens.Colors.onSurfaceVariant,
            ),
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.md),
        )

        NavigationDrawerItem(
            icon = { Icon(DrawerDestination.REMINDERS.icon, contentDescription = null) },
            label = { Text(DrawerDestination.REMINDERS.title) },
            selected = homeDestination is HomeDestination.Reminders,
            onClick = { onDestinationSelected(DrawerDestination.REMINDERS) },
            colors = NavigationDrawerItemDefaults.colors(
                selectedIconColor = AppTokens.Colors.primary,
                selectedTextColor = AppTokens.Colors.primary,
                selectedContainerColor = AppTokens.Colors.primaryContainer,
                unselectedIconColor = AppTokens.Colors.onSurfaceVariant,
                unselectedTextColor = AppTokens.Colors.onSurfaceVariant,
            ),
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.md),
        )

        NavigationDrawerItem(
            icon = { Icon(DrawerDestination.ARCHIVE.icon, contentDescription = null) },
            label = { Text(DrawerDestination.ARCHIVE.title) },
            selected = homeDestination is HomeDestination.Status && homeDestination.status == NoteStatus.ARCHIVED,
            onClick = { onDestinationSelected(DrawerDestination.ARCHIVE) },
            colors = NavigationDrawerItemDefaults.colors(
                selectedIconColor = AppTokens.Colors.primary,
                selectedTextColor = AppTokens.Colors.primary,
                selectedContainerColor = AppTokens.Colors.primaryContainer,
                unselectedIconColor = AppTokens.Colors.onSurfaceVariant,
                unselectedTextColor = AppTokens.Colors.onSurfaceVariant,
            ),
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.md),
        )

        NavigationDrawerItem(
            icon = { Icon(DrawerDestination.TRASH.icon, contentDescription = null) },
            label = { Text(DrawerDestination.TRASH.title) },
            selected = homeDestination is HomeDestination.Status && homeDestination.status == NoteStatus.DELETED,
            onClick = { onDestinationSelected(DrawerDestination.TRASH) },
            colors = NavigationDrawerItemDefaults.colors(
                selectedIconColor = AppTokens.Colors.primary,
                selectedTextColor = AppTokens.Colors.primary,
                selectedContainerColor = AppTokens.Colors.primaryContainer,
                unselectedIconColor = AppTokens.Colors.onSurfaceVariant,
                unselectedTextColor = AppTokens.Colors.onSurfaceVariant,
            ),
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.md),
        )

        HorizontalDivider(
            modifier = Modifier.padding(vertical = AppTokens.Spacing.sm),
            color = AppTokens.Colors.outlineVariant,
        )


        Text(
            "Labels",
            style = MaterialTheme.typography.labelMedium,
            color = AppTokens.Colors.onSurfaceVariant,
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.xl, vertical = AppTokens.Spacing.sm),
        )


        NavigationDrawerItem(
            icon = { Icon(Icons.Outlined.Label, contentDescription = null) },
            label = { Text("Manage labels") },
            selected = false,
            onClick = onManageLabels,
            colors = NavigationDrawerItemDefaults.colors(
                unselectedIconColor = AppTokens.Colors.onSurfaceVariant,
                unselectedTextColor = AppTokens.Colors.onSurfaceVariant,
            ),
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.md),
        )

        Spacer(modifier = Modifier.weight(1f))


        NavigationDrawerItem(
            icon = { Icon(DrawerDestination.SETTINGS.icon, contentDescription = null) },
            label = { Text(DrawerDestination.SETTINGS.title) },
            selected = false,
            onClick = { onDestinationSelected(DrawerDestination.SETTINGS) },
            colors = NavigationDrawerItemDefaults.colors(
                unselectedIconColor = AppTokens.Colors.onSurfaceVariant,
                unselectedTextColor = AppTokens.Colors.onSurfaceVariant,
            ),
            modifier = Modifier.padding(horizontal = AppTokens.Spacing.md),
        )

        Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
    }
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeTopBar(
    title: String,
    onMenuClick: () -> Unit,
    onSearchClick: () -> Unit,
    onSortClick: () -> Unit,
    isGridMode: Boolean,
    onToggleLayout: () -> Unit,
) {
    var showOverflow by remember { mutableStateOf(false) }

    TopAppBar(
        title = {
            Text(
                title,
                style = MaterialTheme.typography.titleMedium,
                color = AppTokens.Colors.onSurface,
            )
        },
        navigationIcon = {
            IconButton(onClick = onMenuClick) {
                Icon(Icons.Filled.Menu, contentDescription = "Open drawer", tint = AppTokens.Colors.onSurface)
            }
        },
        actions = {
            IconButton(onClick = onSearchClick) {
                Icon(Icons.Filled.Search, contentDescription = "Search", tint = AppTokens.Colors.onSurface)
            }
            IconButton(onClick = onToggleLayout) {
                Icon(
                    if (isGridMode) Icons.Outlined.ViewList else Icons.Outlined.GridView,
                    contentDescription = "Toggle layout",
                    tint = AppTokens.Colors.onSurface,
                )
            }
            Box {
                IconButton(onClick = { showOverflow = true }) {
                    Icon(Icons.Filled.MoreVert, contentDescription = "More", tint = AppTokens.Colors.onSurface)
                }
                DropdownMenu(expanded = showOverflow, onDismissRequest = { showOverflow = false }) {
                    DropdownMenuItem(
                        text = { Text("Sort") },
                        leadingIcon = { Icon(Icons.AutoMirrored.Filled.Sort, contentDescription = null) },
                        onClick = {
                            showOverflow = false
                            onSortClick()
                        },
                    )
                }
            }
        },
        colors = TopAppBarDefaults.topAppBarColors(
            containerColor = AppTokens.Colors.surface,
        ),
    )
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SearchTopBar(
    query: String,
    onQueryChange: (String) -> Unit,
    onClose: () -> Unit,
) {
    TopAppBar(
        title = {
            androidx.compose.material3.TextField(
                value = query,
                onValueChange = onQueryChange,
                placeholder = { Text("Search notes...", color = AppTokens.Colors.onSurfaceVariant) },
                singleLine = true,
                colors = androidx.compose.material3.TextFieldDefaults.colors(
                    focusedContainerColor = Color.Transparent,
                    unfocusedContainerColor = Color.Transparent,
                    focusedIndicatorColor = AppTokens.Colors.primary,
                    unfocusedIndicatorColor = Color.Transparent,
                    focusedTextColor = AppTokens.Colors.onSurface,
                    unfocusedTextColor = AppTokens.Colors.onSurface,
                ),
                modifier = Modifier.fillMaxWidth(),
            )
        },
        navigationIcon = {
            IconButton(onClick = onClose) {
                Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Close search",
                    tint = AppTokens.Colors.onSurface)
            }
        },
        colors = TopAppBarDefaults.topAppBarColors(containerColor = AppTokens.Colors.surface),
    )
}


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SelectionTopBar(
    count: Int,
    status: com.maltaisn.notes.model.entity.NoteStatus?,
    pinned: com.maltaisn.notes.model.entity.PinnedStatus,
    hasReminder: Boolean,
    onClose: () -> Unit,
    onPin: () -> Unit,
    onReminder: () -> Unit,
    onLabels: () -> Unit,
    onMove: () -> Unit,
    onDelete: () -> Unit,
    onShare: () -> Unit,
    onCopy: () -> Unit,
    onSelectAll: () -> Unit,
) {
    TopAppBar(
        title = { Text("$count selected", color = AppTokens.Colors.onPrimary) },
        navigationIcon = {
            IconButton(onClick = onClose) {
                Icon(Icons.Filled.Close, contentDescription = "Clear selection",
                    tint = AppTokens.Colors.onPrimary)
            }
        },
        actions = {
            if (count == 1 && status != NoteStatus.DELETED) {
                IconButton(onClick = onShare) {
                    Icon(Icons.Filled.Share, contentDescription = "Share",
                        tint = AppTokens.Colors.onPrimary)
                }
                IconButton(onClick = onCopy) {
                    Icon(Icons.Filled.ContentCopy, contentDescription = "Copy",
                        tint = AppTokens.Colors.onPrimary)
                }
            }
            if (pinned != com.maltaisn.notes.model.entity.PinnedStatus.CANT_PIN) {
                IconButton(onClick = onPin) {
                    Icon(Icons.Filled.PushPin, contentDescription = "Pin/Unpin",
                        tint = AppTokens.Colors.onPrimary)
                }
            }
            if (status != NoteStatus.DELETED) {
                IconButton(onClick = onReminder) {
                    Icon(Icons.Outlined.Alarm, contentDescription = "Reminder",
                        tint = AppTokens.Colors.onPrimary)
                }
                IconButton(onClick = onLabels) {
                    Icon(Icons.Filled.Label, contentDescription = "Labels",
                        tint = AppTokens.Colors.onPrimary)
                }
            }
            IconButton(onClick = onMove) {
                Icon(
                    when (status) {
                        NoteStatus.ACTIVE -> Icons.Filled.Archive
                        NoteStatus.DELETED -> Icons.Filled.Share // restore icon
                        else -> Icons.Filled.Archive
                    },
                    contentDescription = "Move",
                    tint = AppTokens.Colors.onPrimary,
                )
            }
            IconButton(onClick = onDelete) {
                Icon(Icons.Filled.Delete, contentDescription = "Delete",
                    tint = AppTokens.Colors.onPrimary)
            }
            IconButton(onClick = onSelectAll) {
                Icon(Icons.Filled.Check, contentDescription = "Select all",
                    tint = AppTokens.Colors.onPrimary)
            }
        },
        colors = TopAppBarDefaults.topAppBarColors(
            containerColor = AppTokens.Colors.primary,
        ),
    )
}

@Composable
fun SelectionBottomBar(
    count: Int,
    onClose: () -> Unit,
) {
    BottomAppBar(
        containerColor = AppTokens.Colors.surfaceContainerHigh,
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = AppTokens.Spacing.lg),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text(
                "$count selected",
                style = MaterialTheme.typography.labelMedium,
                color = AppTokens.Colors.onSurface,
            )
            TextButton(onClick = onClose) {
                Text("Cancel", color = AppTokens.Colors.primary)
            }
        }
    }
}



@OptIn(ExperimentalFoundationApi::class)
@Composable
fun NotesList(
    homeViewModel: HomeViewModel,
    isGridMode: Boolean,
    isSelectionMode: Boolean,
    onNoteClick: (com.maltaisn.notes.ui.note.adapter.NoteItem, Int) -> Unit,
    onNoteLongClick: (com.maltaisn.notes.ui.note.adapter.NoteItem, Int) -> Unit,
) {
    val noteItems by homeViewModel.noteItems.observeAsState(emptyList())
    val placeholderData by homeViewModel.placeholderData.observeAsState()

    if (noteItems.isEmpty() && placeholderData != null) {
        // Empty state placeholder
        Box(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center,
        ) {
            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                Text(
                    "No notes yet",
                    style = MaterialTheme.typography.headlineMedium,
                    color = AppTokens.Colors.onSurfaceVariant,
                )
                Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
                Text(
                    "Tap + to create your first note",
                    style = MaterialTheme.typography.bodyMedium,
                    color = AppTokens.Colors.onSurfaceVariant,
                )
            }
        }
    } else if (isGridMode) {
        LazyVerticalStaggeredGrid(
            columns = StaggeredGridCells.Fixed(2),
            contentPadding = PaddingValues(AppTokens.Spacing.sm),
            horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
            verticalItemSpacing = AppTokens.Spacing.sm,
        ) {
            items(noteItems, key = { (it as? com.maltaisn.notes.ui.note.adapter.NoteItem)?.note?.id ?: it.hashCode() }) { item ->
                when (item) {
                    is com.maltaisn.notes.ui.note.adapter.HeaderItem -> {
                        Text(
                            item.title.toString(),
                            style = MaterialTheme.typography.labelMedium,
                            color = AppTokens.Colors.onSurfaceVariant,
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontal = AppTokens.Spacing.md, vertical = AppTokens.Spacing.sm),
                        )
                    }
                    is com.maltaisn.notes.ui.note.adapter.MessageItem -> {
                        MessageCard(item)
                    }
                    is com.maltaisn.notes.ui.note.adapter.NoteItem -> {
                        val position = noteItems.indexOf(item)
                        NoteCard(
                            noteItem = item,
                            isGridMode = true,
                            isSelected = item.checked,
                            isSelectionMode = isSelectionMode,
                            onClick = { onNoteClick(item, position) },
                            onLongClick = { onNoteLongClick(item, position) },
                        )
                    }
                }
            }
        }
    } else {
        LazyColumn(
            contentPadding = PaddingValues(AppTokens.Spacing.sm),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
        ) {
            items(noteItems, key = { (it as? com.maltaisn.notes.ui.note.adapter.NoteItem)?.note?.id ?: it.hashCode() }) { item ->
                when (item) {
                    is com.maltaisn.notes.ui.note.adapter.HeaderItem -> {
                        Text(
                            item.title.toString(),
                            style = MaterialTheme.typography.labelMedium,
                            color = AppTokens.Colors.onSurfaceVariant,
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(horizontal = AppTokens.Spacing.md, vertical = AppTokens.Spacing.sm),
                        )
                    }
                    is com.maltaisn.notes.ui.note.adapter.MessageItem -> {
                        MessageCard(item)
                    }
                    is com.maltaisn.notes.ui.note.adapter.NoteItem -> {
                        val position = noteItems.indexOf(item)
                        NoteCard(
                            noteItem = item,
                            isGridMode = false,
                            isSelected = item.checked,
                            isSelectionMode = isSelectionMode,
                            onClick = { onNoteClick(item, position) },
                            onLongClick = { onNoteLongClick(item, position) },
                        )
                    }
                }
            }
        }
    }
}



@OptIn(ExperimentalFoundationApi::class)
@Composable
fun NoteCard(
    noteItem: com.maltaisn.notes.ui.note.adapter.NoteItem,
    isGridMode: Boolean,
    isSelected: Boolean,
    isSelectionMode: Boolean,
    onClick: () -> Unit,
    onLongClick: () -> Unit,
) {
    val note = noteItem.note
    val borderColor = if (isSelected) AppTokens.Colors.primary else AppTokens.Colors.outlineVariant
    val bgColor = if (isSelected) AppTokens.Colors.primaryContainer.copy(alpha = 0.3f)
    else AppTokens.Colors.surfaceContainer

    Card(
        modifier = Modifier
            .fillMaxWidth()
            .combinedClickable(
                onClick = onClick,
                onLongClick = onLongClick,
            ),
        shape = AppTokens.Shapes.medium,
        colors = CardDefaults.cardColors(containerColor = bgColor),
        border = if (isSelected) androidx.compose.foundation.BorderStroke(2.dp, borderColor) else null,
        elevation = CardDefaults.cardElevation(defaultElevation = if (isSelected) 4.dp else 1.dp),
    ) {
        Column(
            modifier = Modifier.padding(AppTokens.Spacing.md),
        ) {

            if (noteItem.note.title.isNotEmpty()) {
                Text(
                    text = noteItem.note.title,
                    style = MaterialTheme.typography.titleMedium,
                    color = AppTokens.Colors.onSurface,
                    maxLines = if (isGridMode) 2 else 1,
                    overflow = TextOverflow.Ellipsis,
                )
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xs))
            }


            if (note.type == NoteType.TEXT && noteItem.note.content.isNotEmpty()) {
                Text(
                    text = noteItem.note.content,
                    style = MaterialTheme.typography.bodyMedium,
                    color = AppTokens.Colors.onSurfaceVariant,
                    maxLines = if (isGridMode) 4 else 2,
                    overflow = TextOverflow.Ellipsis,
                )
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xs))
            }


            if (noteItem.labels.isNotEmpty()) {
                Row(
                    horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs),
                    modifier = Modifier.fillMaxWidth(),
                ) {
                    noteItem.labels.take(3).forEach { label ->
                        Box(
                            modifier = Modifier
                                .clip(AppTokens.Shapes.small)
                                .background(AppTokens.Colors.secondaryContainer)
                                .padding(horizontal = AppTokens.Spacing.sm, vertical = 2.dp),
                        ) {
                            Text(
                                label.name,
                                style = AppTokens.TypographyTokens.caption,
                                color = AppTokens.Colors.onSecondaryContainer,
                                maxLines = 1,
                            )
                        }
                    }
                    if (noteItem.labels.size > 3) {
                        Text(
                            "+${noteItem.labels.size - 3}",
                            style = AppTokens.TypographyTokens.caption,
                            color = AppTokens.Colors.onSurfaceVariant,
                        )
                    }
                }
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xs))
            }

            if (note.reminder != null) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Icon(
                        Icons.Outlined.Alarm,
                        contentDescription = null,
                        modifier = Modifier.size(14.dp),
                        tint = AppTokens.Colors.tertiary,
                    )
                    Spacer(modifier = Modifier.width(AppTokens.Spacing.xs))
                    Text(
                        "Reminder set",
                        style = AppTokens.TypographyTokens.caption,
                        color = AppTokens.Colors.tertiary,
                    )
                }
                Spacer(modifier = Modifier.height(AppTokens.Spacing.xs))
            }

            if (noteItem.showMarkAsDone) {
                TextButton(
                    onClick = onClick,
                    modifier = Modifier.fillMaxWidth(),
                ) {
                    Icon(Icons.Filled.Check, contentDescription = null, modifier = Modifier.size(16.dp))
                    Spacer(modifier = Modifier.width(AppTokens.Spacing.xs))
                    Text("Mark as done", style = AppTokens.TypographyTokens.label)
                }
            }
        }

        if (isSelectionMode) {
            Box(modifier = Modifier.fillMaxSize()) {
                Checkbox(
                    checked = isSelected,
                    onCheckedChange = { onClick() },
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .padding(AppTokens.Spacing.xs),
                )
            }
        }
    }
}


@Composable
fun MessageCard(item: com.maltaisn.notes.ui.note.adapter.MessageItem) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = AppTokens.Shapes.medium,
        colors = CardDefaults.cardColors(
            containerColor = AppTokens.Colors.secondaryContainer,
        ),
    ) {
        Row(
            modifier = Modifier.padding(AppTokens.Spacing.md),
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text(
                item.message.toString(),
                style = MaterialTheme.typography.bodyMedium,
                color = AppTokens.Colors.onSecondaryContainer,
                modifier = Modifier.weight(1f),
            )
            IconButton(onClick = { /* dismiss */ }, modifier = Modifier.size(24.dp)) {
                Icon(Icons.Filled.Close, contentDescription = "Dismiss",
                    modifier = Modifier.size(16.dp), tint = AppTokens.Colors.onSecondaryContainer)
            }
        }
    }
}


fun HomeDestination.title(): String = when (this) {
    is HomeDestination.Status -> when (this.status) {
        NoteStatus.ACTIVE -> "Notes"
        NoteStatus.ARCHIVED -> "Archive"
        NoteStatus.DELETED -> "Trash"
    }
    is HomeDestination.Labels -> this.label.name
    is HomeDestination.Reminders -> "Reminders"
}

fun handleDrawerNavigation(
    dest: DrawerDestination,
    mainViewModel: HomeMainViewModel,
    onNavigateToSettings: () -> Unit,
) {
    when (dest) {
        DrawerDestination.NOTES -> mainViewModel.navigateToDestination(HomeDestination.Status(NoteStatus.ACTIVE))
        DrawerDestination.REMINDERS -> mainViewModel.navigateToDestination(HomeDestination.Reminders)
        DrawerDestination.ARCHIVE -> mainViewModel.navigateToDestination(HomeDestination.Status(NoteStatus.ARCHIVED))
        DrawerDestination.TRASH -> mainViewModel.navigateToDestination(HomeDestination.Status(NoteStatus.DELETED))
        DrawerDestination.SETTINGS -> onNavigateToSettings()
    }
}
@Preview(name = "Home — Grid Mode", showBackground = true, backgroundColor = 0xFFF8FBF1)
@Composable
private fun PreviewHomeGrid() {
    HomePreview(notes = sampleNotes, isGridMode = true)
}

@Composable
private fun HomePreview(notes: List<Pair<String, String>>, isGridMode: Boolean = false) {
    val drawerState = rememberDrawerState(DrawerValue.Closed)
    val scope = rememberCoroutineScope()
    var gridMode by remember { mutableStateOf(isGridMode) }

    AppTheme {
        Surface(color = MaterialTheme.colorScheme.background) {
            ModalNavigationDrawer(
                drawerState = drawerState,
                drawerContent = {
                    ModalDrawerSheet(
                        modifier = Modifier.width(320.dp),
                        drawerContainerColor = AppTokens.Colors.surface,
                    ) {
                        NavigationDrawerContent(
                            appName = "Notes",
                            homeDestination = HomeDestination.Status(NoteStatus.ACTIVE),
                            onDestinationSelected = { scope.launch { drawerState.close() } },
                            onManageLabels = { scope.launch { drawerState.close() } },
                            onCreateLabel = { scope.launch { drawerState.close() } },
                        )
                    }
                },
            ) {
                Scaffold(
                    containerColor = AppTokens.Colors.background,
                    topBar = {
                        HomeTopBar(
                            title = "Notes",
                            onMenuClick = { scope.launch { drawerState.open() } },
                            onSearchClick = {},
                            onSortClick = {},
                            isGridMode = gridMode,
                            onToggleLayout = { gridMode = !gridMode },
                        )
                    },
                    floatingActionButton = {
                        FloatingActionButton(
                            onClick = {},
                            containerColor = AppTokens.Colors.primaryContainer,
                            contentColor = AppTokens.Colors.onPrimaryContainer,
                            shape = AppTokens.Shapes.large,
                        ) {
                            Icon(Icons.Filled.Add, contentDescription = "Create Note")
                        }
                    },
                ) { padding ->
                    if (notes.isEmpty()) {
                        Box(
                            modifier = Modifier.padding(padding).fillMaxSize(),
                            contentAlignment = Alignment.Center,
                        ) {
                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                Text("No notes yet", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onSurfaceVariant)
                                Spacer(modifier = Modifier.height(8.dp))
                                Text("Tap + to create your first note", style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurfaceVariant)
                            }
                        }
                    } else if (gridMode) {
                        LazyVerticalStaggeredGrid(
                            columns = StaggeredGridCells.Fixed(2),
                            modifier = Modifier.padding(padding).fillMaxSize(),
                            contentPadding = PaddingValues(AppTokens.Spacing.lg),
                            horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                            verticalItemSpacing = AppTokens.Spacing.sm,
                        ) {
                            items(notes.size) { index ->
                                val (title, content) = notes[index]
                                Card(
                                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                                    shape = AppTokens.Shapes.medium,
                                ) {
                                    Column(modifier = Modifier.padding(AppTokens.Spacing.md)) {
                                        Text(title, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface, maxLines = 2, overflow = TextOverflow.Ellipsis)
                                        Spacer(modifier = Modifier.height(4.dp))
                                        Text(content, style = MaterialTheme.typography.bodySmall, color = AppTokens.Colors.onSurfaceVariant, maxLines = 3, overflow = TextOverflow.Ellipsis)
                                    }
                                }
                            }
                        }
                    } else {
                        LazyColumn(
                            modifier = Modifier.padding(padding).fillMaxSize(),
                            contentPadding = PaddingValues(AppTokens.Spacing.lg),
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                        ) {
                            items(notes.size) { index ->
                                val (title, content) = notes[index]
                                Card(
                                    colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                                    shape = AppTokens.Shapes.medium,
                                    modifier = Modifier.fillMaxWidth(),
                                ) {
                                    Column(modifier = Modifier.padding(AppTokens.Spacing.md)) {
                                        Text(title, style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface, maxLines = 1, overflow = TextOverflow.Ellipsis)
                                        Spacer(modifier = Modifier.height(4.dp))
                                        Text(content, style = MaterialTheme.typography.bodySmall, color = AppTokens.Colors.onSurfaceVariant, maxLines = 2, overflow = TextOverflow.Ellipsis)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private val sampleNotes = listOf(
    "Today's first note" to "Thought of it this morning, jotting it down",
    "Weekend shopping list" to "Milk, eggs, bread, butter, cheese, apples, bananas",
    "Meeting minutes — Q3 planning" to "Discussed roadmap, next quarter focus on search and sync",
    "Book notes" to "Atomic Habits — improve 1% every day, that's 37x in a year",
    "Workout plan" to "Monday chest + triceps, Wednesday back + biceps, Friday legs + shoulders",
)



@AndroidEntryPoint
class HomeActivity : FragmentActivity(), NavigationHost {

    private val sharedViewModel: SharedViewModel by viewModels()
    private val homeViewModel: HomeViewModel by viewModels()
    private val mainViewModel: HomeMainViewModel by viewModels()

    @Inject
    lateinit var prefs: PrefsManager

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Edge-to-edge
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())

        mainViewModel.startPopulatingDrawerWithLabels()

        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    HomePreview(notes = sampleNotes, isGridMode = true)
                }
            }
        }

        setupViewModelObservers()
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior =
                WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }

    override fun onResume() {
        super.onResume()
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        this.intent = intent
    }

    override fun onKeyShortcut(keyCode: Int, event: KeyEvent): Boolean {
        if (event.hasModifiers(KeyEvent.META_CTRL_ON)) {
            when (event.keyCode) {
                KeyEvent.KEYCODE_Z -> { sharedViewModel.undo(); return true }
                KeyEvent.KEYCODE_Y -> { sharedViewModel.redo(); return true }
            }
        } else if (event.hasModifiers(KeyEvent.META_CTRL_ON or KeyEvent.META_SHIFT_ON)) {
            when (event.keyCode) {
                KeyEvent.KEYCODE_Z -> { sharedViewModel.redo(); return true }
            }
        }
        return super.onKeyShortcut(keyCode, event)
    }

    private fun setupViewModelObservers() {
        mainViewModel.editItemEvent.observeEvent(this) { noteId ->
            navigateToEditNote(noteId)
        }
        mainViewModel.createNoteEvent.observeEvent(this) { newNoteData ->
            val intent = Intent(this, EditActivity::class.java).apply {
                putExtra(EXTRA_NOTE_ID, Note.NO_ID)
                putExtra(EXTRA_NOTE_TYPE, newNoteData.type.value)
                putExtra(EXTRA_NOTE_TITLE, newNoteData.title)
                putExtra(EXTRA_NOTE_CONTENT, newNoteData.content)
            }
            startActivity(intent)
        }
        mainViewModel.navigateToEditLabelsEvent.observeEvent(this) {
            navigateToLabel(longArrayOf())
        }
        mainViewModel.navigateToSettingsEvent.observeEvent(this) {
            navigateToSettings()
        }

        homeViewModel.editItemEvent.observeEvent(this) { (noteId, _) ->
            navigateToEditNote(noteId)
        }

        sharedViewModel.noteCreatedEvent.observeEvent(this) { noteId ->
        }
    }

    private fun handleIntent(intent: Intent) {
        if (!intent.getBooleanExtra(KEY_INTENT_HANDLED, false)) {
            when (intent.action) {
                Intent.ACTION_APPLICATION_PREFERENCES -> {
                    navigateToSettings()
                }
            }
            intent.putExtra(KEY_INTENT_HANDLED, true)
        }
    }


    override fun navigateToEditNote(
        noteId: Long, labelId: Long, changeReminder: Boolean,
        type: com.maltaisn.notes.model.entity.NoteType?, title: String, content: String,
        sharedView: android.view.View?,
    ) {
        val intent = Intent(this, EditActivity::class.java).apply {
            putExtra(EXTRA_NOTE_ID, noteId)
        }
        startActivity(intent)
    }

    override fun navigateToSearch() {
        // Search is handled inline in the Compose UI
    }

    override fun navigateToLabel(noteIds: LongArray) {
        val intent = Intent(this, LabelActivity::class.java).apply {
            putExtra("com.maltaisn.notes.NOTE_IDS", noteIds)
        }
        startActivity(intent)
    }

    override fun navigateToReminder(noteIds: LongArray) {
        val dialog = com.maltaisn.notes.ui.reminder.ReminderDialog()
        dialog.arguments = Bundle().apply {
            putLongArray("noteIds", noteIds)
        }
        dialog.show(supportFragmentManager, "reminder_dialog")
    }

    override fun navigateToSettings() {
        startActivity(Intent(this, SettingsActivity::class.java))
    }

    override fun navigateBack() {
        finish()
    }

    override fun showSortDialog() {
        com.maltaisn.notes.ui.sort.SortDialog().show(supportFragmentManager, "sort_dialog")
    }

    override fun showLabelEditDialog(labelId: Long) {
        val dialog = com.maltaisn.notes.ui.labels.LabelEditDialog()
        if (labelId != 0L) {
            dialog.arguments = Bundle().apply { putLong("labelId", labelId) }
        }
        dialog.show(supportFragmentManager, "label_edit_dialog")
    }

    companion object {
        private const val KEY_INTENT_HANDLED = "com.maltaisn.notes.INTENT_HANDLED"
    }
}

