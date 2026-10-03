

package com.shub39.grit.shared.ui.setting.ui

import androidx.compose.animation.AnimatedContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp



private enum class AppTheme { SYSTEM, DARK, LIGHT }

private enum class Fonts {
    POPPINS, INTER, MANROPE, MONTSERRAT, FIGTREE, OUTFIT, GOOGLE_SANS, SYSTEM_DEFAULT
}

private enum class PaletteStyle {
    TONALSPOT, NEUTRAL, VIBRANT, EXPRESSIVE, RAINBOW, FRUITSALAD, MONOCHROME, FIDELITY, CONTENT
}

private data class Theme(
    val appTheme: AppTheme = AppTheme.SYSTEM,
    val isAmoled: Boolean = false,
    val isMaterialYou: Boolean = false,
    val font: Fonts = Fonts.FIGTREE,
    val paletteStyle: PaletteStyle = PaletteStyle.TONALSPOT,
    val seedColor: Long = 0xFF6750A4,
)

private enum class ExportState { IDLE, EXPORTING, EXPORTED }

private enum class RestoreState { IDLE, RESTORING, RESTORED, FAILURE }

private data class BackupState(
    val exportState: ExportState = ExportState.IDLE,
    val restoreState: RestoreState = RestoreState.IDLE,
)

private enum class Sections { Tasks, Habits }

private data class SettingsState(
    val changelog: List<VersionEntry> = emptyList(),
    val currentVersion: String = "1.0.0",
    val backupState: BackupState = BackupState(),
    val theme: Theme = Theme(),
    val is24Hr: Boolean = false,
    val reorderTasks: Boolean = false,
    val startOfTheWeekSunday: Boolean = false,
    val pauseNotifications: Boolean = false,
    val startingPage: Sections = Sections.Tasks,
    val isBiometricLockOn: Boolean = false,
    val isBiometricLockAvailable: Boolean = true,
)

private data class VersionEntry(val version: String, val changes: List<String>)



private val mockChangelog = listOf(
    VersionEntry(
        version = "1.3.0",
        changes = listOf(
            "Added biometric lock support",
            "New palette styles: Rainbow, Fruit Salad",
            "Improved backup & restore performance",
            "Fixed notification scheduling bug",
        ),
    ),
    VersionEntry(
        version = "1.2.0",
        changes = listOf(
            "Introduced Material You theming",
            "Added font picker with 8 font choices",
            "Export/import settings backup",
            "Redesigned habit analytics page",
        ),
    ),
    VersionEntry(
        version = "1.1.0",
        changes = listOf(
            "Added habit calendar view",
            "Overall analytics page",
            "Bug fixes and performance improvements",
        ),
    ),
    VersionEntry(
        version = "1.0.0",
        changes = listOf("Initial release", "Basic habit tracking", "Task management"),
    ),
)

private val mockSettingsState = SettingsState(
    changelog = mockChangelog,
    currentVersion = "1.3.0",
    backupState = BackupState(exportState = ExportState.IDLE, restoreState = RestoreState.IDLE),
    theme = Theme(
        appTheme = AppTheme.SYSTEM,
        isAmoled = false,
        isMaterialYou = true,
        font = Fonts.FIGTREE,
        paletteStyle = PaletteStyle.TONALSPOT,
        seedColor = 0xFF6750A4,
    ),
    is24Hr = false,
    reorderTasks = false,
    startOfTheWeekSunday = false,
    pauseNotifications = false,
    startingPage = Sections.Tasks,
    isBiometricLockOn = false,
    isBiometricLockAvailable = true,
)



private enum class SettingsScreen {
    Root, LookAndFeel, Backup, Changelog, About
}



private fun leadingItemShape() = RoundedCornerShape(topStart = 28.dp, topEnd = 28.dp)
private fun middleItemShape() = RoundedCornerShape(0.dp)
private fun endItemShape() = RoundedCornerShape(bottomStart = 28.dp, bottomEnd = 28.dp)
private fun detachedItemShape() = RoundedCornerShape(28.dp)

@Composable
private fun GroupedListItem(
    headline: String,
    supporting: String = "",
    leadingIcon: String = "",
    trailingIcon: String = "",
    shape: androidx.compose.ui.graphics.Shape = RoundedCornerShape(0.dp),
    onClick: (() -> Unit)? = null,
    trailing: @Composable (() -> Unit)? = null,
) {
    ListItem(
        headlineContent = { Text(headline, fontWeight = FontWeight.Medium) },
        supportingContent = if (supporting.isNotEmpty()) {
            { Text(supporting, color = MaterialTheme.colorScheme.onSurfaceVariant) }
        } else null,
        leadingContent = if (leadingIcon.isNotEmpty()) {
            {
                Box(
                    modifier = Modifier.size(40.dp).clip(CircleShape)
                        .background(MaterialTheme.colorScheme.surfaceContainerHighest),
                    contentAlignment = Alignment.Center,
                ) { Text(leadingIcon, style = MaterialTheme.typography.titleMedium) }
            }
        } else null,
        trailingContent = trailing ?: if (trailingIcon.isNotEmpty()) {
            { Text(trailingIcon, color = MaterialTheme.colorScheme.onSurfaceVariant) }
        } else null,
        modifier = Modifier.clip(shape).then(
            if (onClick != null) Modifier.clickable { onClick() } else Modifier
        ),
    )
}



@Composable
fun SettingsGraphPreview() {
    var currentScreen by remember { mutableStateOf(SettingsScreen.Root) }

    
    var state by remember { mutableStateOf(mockSettingsState) }

    AnimatedContent(targetState = currentScreen) { screen ->
        when (screen) {
            SettingsScreen.Root -> SettingsListPage(
                state = state,
                onTogglePauseNotifications = { state = state.copy(pauseNotifications = it) },
                onToggleReorderTasks = { state = state.copy(reorderTasks = it) },
                onToggleShowHabits = {
                    state = state.copy(
                        startingPage = if (it) Sections.Habits else Sections.Tasks
                    )
                },
                onToggleStartOfWeek = {
                    state = state.copy(startOfTheWeekSunday = it)
                },
                onToggleBiometric = {
                    state = state.copy(isBiometricLockOn = it)
                },
                onToggle24Hr = { state = state.copy(is24Hr = it) },
                onNavigateToLookAndFeel = { currentScreen = SettingsScreen.LookAndFeel },
                onNavigateToBackup = { currentScreen = SettingsScreen.Backup },
                onNavigateToChangelog = { currentScreen = SettingsScreen.Changelog },
                onNavigateToAbout = { currentScreen = SettingsScreen.About },
            )

            SettingsScreen.LookAndFeel -> LookAndFeelPage(
                theme = state.theme,
                onChangeAppTheme = {
                    state = state.copy(theme = state.theme.copy(appTheme = it))
                },
                onChangeMaterialYou = {
                    state = state.copy(theme = state.theme.copy(isMaterialYou = it))
                },
                onChangeFont = {
                    state = state.copy(theme = state.theme.copy(font = it))
                },
                onChangeAmoled = {
                    state = state.copy(theme = state.theme.copy(isAmoled = it))
                },
                onChangeSeedColor = {
                    state = state.copy(theme = state.theme.copy(seedColor = it))
                },
                onChangePaletteStyle = {
                    state = state.copy(theme = state.theme.copy(paletteStyle = it))
                },
                onBack = { currentScreen = SettingsScreen.Root },
            )

            SettingsScreen.Backup -> BackupPage(
                backupState = state.backupState,
                onExport = {
                    state = state.copy(
                        backupState = state.backupState.copy(exportState = ExportState.EXPORTING)
                    )
                },
                onRestore = {
                    state = state.copy(
                        backupState = state.backupState.copy(restoreState = RestoreState.RESTORING)
                    )
                },
                onBack = { currentScreen = SettingsScreen.Root },
            )

            SettingsScreen.Changelog -> ChangelogPage(
                changelog = state.changelog,
                onBack = { currentScreen = SettingsScreen.Root },
            )

            SettingsScreen.About -> AboutPage(
                versionName = state.currentVersion,
                onBack = { currentScreen = SettingsScreen.Root },
            )
        }
    }
}



@Composable
private fun SettingsListPage(
    state: SettingsState,
    onTogglePauseNotifications: (Boolean) -> Unit,
    onToggleReorderTasks: (Boolean) -> Unit,
    onToggleShowHabits: (Boolean) -> Unit,
    onToggleStartOfWeek: (Boolean) -> Unit,
    onToggleBiometric: (Boolean) -> Unit,
    onToggle24Hr: (Boolean) -> Unit,
    onNavigateToLookAndFeel: () -> Unit,
    onNavigateToBackup: () -> Unit,
    onNavigateToChangelog: () -> Unit,
    onNavigateToAbout: () -> Unit,
) {
    var showLanguagePicker by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            LargeTopAppBar(
                title = { Text("Settings", fontWeight = FontWeight.Bold) },
                colors = TopAppBarDefaults.largeTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(start = 12.dp, end = 12.dp, top = 16.dp, bottom = 60.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            
            item {
                GroupedListItem(
                    headline = "Grit Plus",
                    leadingIcon = "🛡",
                    trailingIcon = "",
                    shape = detachedItemShape(),
                    onClick = { },
                    trailing = {
                        Text("→", color = MaterialTheme.colorScheme.onSurfaceVariant)
                    },
                )
            }


            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {

                    SwitchSettingItem(
                        headline = "Pause Notifications",
                        supporting = "Temporarily pause all habit reminders",
                        checked = state.pauseNotifications,
                        onCheckedChange = onTogglePauseNotifications,
                        shape = leadingItemShape(),
                    )


                    SwitchSettingItem(
                        headline = "Reorder Tasks",
                        supporting = "Drag to reorder tasks in the list",
                        checked = state.reorderTasks,
                        onCheckedChange = onToggleReorderTasks,
                        shape = middleItemShape(),
                    )


                    SwitchSettingItem(
                        headline = "Show Habits",
                        supporting = "Start the app on the Habits page",
                        checked = state.startingPage == Sections.Habits,
                        onCheckedChange = onToggleShowHabits,
                        shape = middleItemShape(),
                    )


                    SwitchSettingItem(
                        headline = "Starting Day",
                        supporting = "Start week on Sunday instead of Monday",
                        checked = state.startOfTheWeekSunday,
                        onCheckedChange = onToggleStartOfWeek,
                        shape = middleItemShape(),
                    )


                    if (state.isBiometricLockAvailable) {
                        SwitchSettingItem(
                            headline = "Biometric Lock",
                            supporting = "Require fingerprint to open the app",
                            checked = state.isBiometricLockOn,
                            onCheckedChange = onToggleBiometric,
                            shape = middleItemShape(),
                        )
                    }


                    SwitchSettingItem(
                        headline = "Use 24-Hour Time",
                        supporting = "Display time in 24-hour format",
                        checked = state.is24Hr,
                        onCheckedChange = onToggle24Hr,
                        shape = endItemShape(),
                    )
                }
            }


            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    GroupedListItem(
                        headline = "Look & Feel",
                        supporting = "Customize theme, font, and colors",
                        leadingIcon = "🎨",
                        trailingIcon = "→",
                        shape = leadingItemShape(),
                        onClick = onNavigateToLookAndFeel,
                    )
                    GroupedListItem(
                        headline = "Backup",
                        supporting = "Export or restore your data",
                        leadingIcon = "⬇",
                        trailingIcon = "→",
                        shape = endItemShape(),
                        onClick = onNavigateToBackup,
                    )
                }
            }


            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    GroupedListItem(
                        headline = "About",
                        supporting = "Grit ${state.currentVersion}",
                        leadingIcon = "ℹ",
                        trailingIcon = "→",
                        shape = leadingItemShape(),
                        onClick = onNavigateToAbout,
                    )
                    GroupedListItem(
                        headline = "Changelog",
                        leadingIcon = "✓",
                        trailingIcon = "→",
                        shape = endItemShape(),
                        onClick = onNavigateToChangelog,
                    )
                }
            }


            item {
                GroupedListItem(
                    headline = "Language",
                    supporting = "English",
                    leadingIcon = "🌐",
                    trailingIcon = "→",
                    shape = detachedItemShape(),
                    onClick = { showLanguagePicker = true },
                )
            }
        }
    }


    if (showLanguagePicker) {
        LanguagePickerSheet(onDismiss = { showLanguagePicker = false })
    }
}

@Composable
private fun SwitchSettingItem(
    headline: String,
    supporting: String,
    checked: Boolean,
    onCheckedChange: (Boolean) -> Unit,
    shape: androidx.compose.ui.graphics.Shape,
) {
    ListItem(
        headlineContent = { Text(headline, fontWeight = FontWeight.Medium) },
        supportingContent = {
            Text(supporting, color = MaterialTheme.colorScheme.onSurfaceVariant)
        },
        trailingContent = {
            Switch(checked = checked, onCheckedChange = onCheckedChange)
        },
        modifier = Modifier.clip(shape),
    )
}

@Composable
private fun LanguagePickerSheet(onDismiss: () -> Unit) {
    val languages = listOf(
        "English" to "en",
        "Deutsch" to "de",
        "Français" to "fr",
        "Español" to "es",
        "Português" to "pt",
        "Русский" to "ru",
        "日本語" to "ja",
        "한국어" to "ko",
        "中文" to "zh",
    )

    ModalBottomSheet(onDismissRequest = onDismiss) {
        Column(modifier = Modifier.padding(bottom = 32.dp)) {
            Text(
                "Select Language",
                style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Bold),
                modifier = Modifier.padding(horizontal = 24.dp, vertical = 8.dp),
            )
            languages.forEach { (name, _) ->
                ListItem(
                    headlineContent = { Text(name) },
                    modifier = Modifier.clickable { onDismiss() },
                )
            }
        }
    }
}


@Composable
private fun LookAndFeelPage(
    theme: Theme,
    onChangeAppTheme: (AppTheme) -> Unit,
    onChangeMaterialYou: (Boolean) -> Unit,
    onChangeFont: (Fonts) -> Unit,
    onChangeAmoled: (Boolean) -> Unit,
    onChangeSeedColor: (Long) -> Unit,
    onChangePaletteStyle: (PaletteStyle) -> Unit,
    onBack: () -> Unit,
) {
    var showColorPicker by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            MediumTopAppBar(
                title = { Text("Look & Feel", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←")
                    }
                },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(start = 12.dp, end = 12.dp, top = 16.dp, bottom = 60.dp),
        ) {
            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {

                    Column(modifier = Modifier.clip(leadingItemShape())) {
                        ListItem(
                            headlineContent = {
                                Text("App Theme", fontWeight = FontWeight.Medium)
                            },
                            leadingContent = {
                                Text(
                                    when (theme.appTheme) {
                                        AppTheme.SYSTEM -> "⚙"
                                        AppTheme.DARK -> "🌙"
                                        AppTheme.LIGHT -> "☀"
                                    },
                                    style = MaterialTheme.typography.titleMedium,
                                )
                            },
                        )

                        Row(
                            horizontalArrangement = Arrangement.spacedBy(8.dp),
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(start = 52.dp, end = 16.dp, bottom = 8.dp),
                        ) {
                            AppTheme.entries.forEach { appTheme ->
                                ToggleButton(
                                    checked = appTheme == theme.appTheme,
                                    onCheckedChange = { onChangeAppTheme(appTheme) },
                                    modifier = Modifier.weight(1f),
                                ) {
                                    Text(
                                        when (appTheme) {
                                            AppTheme.SYSTEM -> "System"
                                            AppTheme.DARK -> "Dark"
                                            AppTheme.LIGHT -> "Light"
                                        },
                                        maxLines = 1,
                                        overflow = TextOverflow.Ellipsis,
                                    )
                                }
                            }
                        }
                    }


                    SwitchSettingItem(
                        headline = "Material You",
                        supporting = "Use dynamic colors from your wallpaper",
                        checked = theme.isMaterialYou,
                        onCheckedChange = onChangeMaterialYou,
                        shape = middleItemShape(),
                    )


                    Column(
                        modifier = Modifier.clip(
                            if (theme.isMaterialYou) endItemShape() else middleItemShape()
                        ),
                    ) {
                        ListItem(
                            headlineContent = {
                                Text("Font", fontWeight = FontWeight.Medium)
                            },
                            leadingContent = {
                                Text("F", style = MaterialTheme.typography.titleMedium)
                            },
                        )

                        FlowRow(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(start = 52.dp, end = 16.dp, bottom = 8.dp),
                            horizontalArrangement = Arrangement.spacedBy(4.dp),
                        ) {
                            Fonts.entries.forEach { font ->
                                ToggleButton(
                                    checked = theme.font == font,
                                    onCheckedChange = { onChangeFont(font) },
                                ) {
                                    Text(
                                        font.name.lowercase().replaceFirstChar { it.uppercase() },
                                        maxLines = 1,
                                    )
                                }
                            }
                        }
                    }


                    if (!theme.isMaterialYou) {
                        SwitchSettingItem(
                            headline = "Use AMOLED Black",
                            supporting = "Enable pure black for AMOLED screens",
                            checked = theme.isAmoled,
                            onCheckedChange = onChangeAmoled,
                            shape = middleItemShape(),
                        )


                        ListItem(
                            headlineContent = {
                                Text("Select Seed Color", fontWeight = FontWeight.Medium)
                            },
                            supportingContent = {
                                Text(
                                    "Choose a base color for the theme",
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                            },
                            trailingContent = {
                                IconButton(onClick = { showColorPicker = true }) {
                                    Box(
                                        modifier = Modifier
                                            .size(32.dp)
                                            .clip(CircleShape)
                                            .background(Color(theme.seedColor)),
                                    )
                                }
                            },
                            modifier = Modifier.clip(middleItemShape()),
                        )


                        Column(modifier = Modifier.clip(endItemShape())) {
                            ListItem(
                                headlineContent = {
                                    Text("Palette Style", fontWeight = FontWeight.Medium)
                                },
                                leadingContent = {
                                    Text("🎨", style = MaterialTheme.typography.titleMedium)
                                },
                            )

                            FlowRow(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(start = 52.dp, end = 16.dp, bottom = 8.dp),
                                horizontalArrangement = Arrangement.spacedBy(4.dp),
                            ) {
                                PaletteStyle.entries.forEach { style ->
                                    ToggleButton(
                                        checked = theme.paletteStyle == style,
                                        onCheckedChange = { onChangePaletteStyle(style) },
                                    ) {
                                        Text(
                                            style.name.lowercase()
                                                .replaceFirstChar { it.uppercase() },
                                            maxLines = 1,
                                            fontSize = MaterialTheme.typography.labelMedium.fontSize,
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    if (showColorPicker) {
        ColorPickerSheet(
            currentColor = Color(theme.seedColor),
            onSelect = { onChangeSeedColor(it.value.toLong()) },
            onDismiss = { showColorPicker = false },
        )
    }
}

@Composable
private fun ColorPickerSheet(
    currentColor: Color,
    onSelect: (Color) -> Unit,
    onDismiss: () -> Unit,
) {
    val presetColors = listOf(
        Color(0xFF6750A4), 
        Color(0xFF1B6EF3), 
        Color(0xFF0A7E2C), 
        Color(0xFFBA1A1A), 
        Color(0xFFE8650A), 
        Color(0xFF7C5800), 
        Color(0xFF006A6A), 
        Color(0xFF9C3E84), 
        Color(0xFF44464F), 
    )

    ModalBottomSheet(onDismissRequest = onDismiss) {
        Column(modifier = Modifier.padding(24.dp).padding(bottom = 32.dp)) {
            Text(
                "Select Color",
                style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Bold),
            )
            Spacer(Modifier.height(16.dp))

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly,
            ) {
                presetColors.forEach { color ->
                    val isSelected = color == currentColor
                    Box(
                        modifier = Modifier
                            .size(40.dp)
                            .clip(CircleShape)
                            .background(color)
                            .then(
                                if (isSelected) {
                                    Modifier.border(3.dp, MaterialTheme.colorScheme.onSurface, CircleShape)
                                } else Modifier
                            )
                            .clickable { onSelect(color) },
                    )
                }
            }

            Spacer(Modifier.height(24.dp))
            TextButton(onClick = onDismiss, modifier = Modifier.align(Alignment.End)) {
                Text("Done")
            }
        }
    }
}



@Composable
private fun BackupPage(
    backupState: BackupState,
    onExport: () -> Unit,
    onRestore: () -> Unit,
    onBack: () -> Unit,
) {
    Scaffold(
        topBar = {
            MediumTopAppBar(
                title = { Text("Backup", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←")
                    }
                },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(start = 12.dp, end = 12.dp, top = 16.dp, bottom = 60.dp),
        ) {
            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {

                    
                    Column(modifier = Modifier.clip(leadingItemShape())) {
                        ListItem(
                            headlineContent = {
                                Text("Export", fontWeight = FontWeight.Medium)
                            },
                            supportingContent = {
                                Text(
                                    "Save all your data as a JSON file",
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                            },
                            leadingContent = {
                                Text("📤", style = MaterialTheme.typography.titleMedium)
                            },
                        )

                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(start = 52.dp, end = 16.dp, bottom = 8.dp),
                        ) {
                            Button(
                                onClick = onExport,
                                enabled = backupState.exportState == ExportState.IDLE,
                                modifier = Modifier.weight(1f),
                            ) {
                                when (backupState.exportState) {
                                    ExportState.IDLE -> Text("▶ Export")
                                    ExportState.EXPORTING -> {
                                        CircularProgressIndicator(
                                            modifier = Modifier.size(20.dp),
                                            strokeWidth = 2.dp,
                                        )
                                        Spacer(Modifier.width(8.dp))
                                        Text("Exporting…")
                                    }
                                    ExportState.EXPORTED -> Text("✓ Done")
                                }
                            }
                        }
                    }

                    
                    Column(modifier = Modifier.clip(endItemShape())) {
                        ListItem(
                            headlineContent = {
                                Text("Restore", fontWeight = FontWeight.Medium)
                            },
                            supportingContent = {
                                Text(
                                    "Restore data from a backup file",
                                    color = MaterialTheme.colorScheme.onSurfaceVariant,
                                )
                            },
                            leadingContent = {
                                Text("⬇", style = MaterialTheme.typography.titleMedium)
                            },
                        )

                        Row(
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(start = 52.dp, end = 16.dp, bottom = 8.dp),
                        ) {
                            Button(
                                onClick = onRestore,
                                enabled = backupState.restoreState == RestoreState.IDLE
                                        || backupState.restoreState == RestoreState.FAILURE,
                                modifier = Modifier.weight(1f),
                            ) {
                                when (backupState.restoreState) {
                                    RestoreState.IDLE -> Text("▶ Restore")
                                    RestoreState.RESTORING -> {
                                        CircularProgressIndicator(
                                            modifier = Modifier.size(20.dp),
                                            strokeWidth = 2.dp,
                                        )
                                        Spacer(Modifier.width(8.dp))
                                        Text("Restoring…")
                                    }
                                    RestoreState.RESTORED -> Text("✓ Done")
                                    RestoreState.FAILURE -> Text("⚠ Failed — tap to retry")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}



@Composable
private fun ChangelogPage(
    changelog: List<VersionEntry>,
    onBack: () -> Unit,
) {
    Scaffold(
        topBar = {
            MediumTopAppBar(
                title = { Text("Changelog", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←")
                    }
                },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(start = 16.dp, end = 16.dp, top = 16.dp, bottom = 60.dp),
            verticalArrangement = Arrangement.spacedBy(2.dp),
        ) {
            changelog.forEach { versionEntry ->
                item {
                    Text(
                        text = versionEntry.version,
                        style = MaterialTheme.typography.headlineSmall.copy(
                            fontWeight = FontWeight.Bold
                        ),
                        modifier = Modifier.padding(top = 16.dp, bottom = 8.dp),
                    )
                }

                itemsIndexed(versionEntry.changes) { index, change ->
                    val shape = when {
                        versionEntry.changes.size == 1 -> detachedItemShape()
                        index == 0 -> leadingItemShape()
                        index == versionEntry.changes.size - 1 -> endItemShape()
                        else -> middleItemShape()
                    }

                    ListItem(
                        headlineContent = { Text(change) },
                        modifier = Modifier.clip(shape),
                    )
                }

                item { Spacer(Modifier.height(16.dp)) }
            }
        }
    }
}



@Composable
private fun AboutPage(
    versionName: String,
    onBack: () -> Unit,
) {
    var showLicense by remember { mutableStateOf(false) }

    Scaffold(
        topBar = {
            MediumTopAppBar(
                title = { Text("About", fontWeight = FontWeight.Bold) },
                navigationIcon = {
                    FilledTonalIconButton(onClick = onBack) {
                        Text("←")
                    }
                },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    scrolledContainerColor = MaterialTheme.colorScheme.surface,
                ),
            )
        },
    ) { padding ->
        LazyColumn(
            modifier = Modifier.fillMaxSize().padding(padding),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {

                    Card(shape = leadingItemShape()) {
                        Row(
                            modifier = Modifier.padding(16.dp).fillMaxWidth(),
                            verticalAlignment = Alignment.CenterVertically,
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(64.dp)
                                    .background(
                                        color = MaterialTheme.colorScheme.primaryContainer,
                                        shape = RoundedCornerShape(16.dp),
                                    ),
                                contentAlignment = Alignment.Center,
                            ) {
                                Text(
                                    "🛡",
                                    style = MaterialTheme.typography.headlineMedium,
                                )
                            }

                            Spacer(Modifier.width(16.dp))

                            Column(modifier = Modifier.weight(1f)) {
                                Text(
                                    "Grit",
                                    style = MaterialTheme.typography.headlineMedium.copy(
                                        fontWeight = FontWeight.Bold
                                    ),
                                )
                                Text(
                                    versionName,
                                    style = MaterialTheme.typography.titleMedium.copy(
                                        color = MaterialTheme.colorScheme.primary
                                    ),
                                )
                            }

                            FilledTonalIconButton(
                                onClick = { },
                                modifier = Modifier.size(40.dp),
                            ) {
                                Text("💬", style = MaterialTheme.typography.titleSmall)
                            }
                            Spacer(Modifier.width(8.dp))
                            FilledTonalIconButton(
                                onClick = { },
                                modifier = Modifier.size(40.dp),
                            ) {
                                Text("🐙", style = MaterialTheme.typography.titleSmall)
                            }
                        }
                    }

                    Card(shape = endItemShape()) {
                        Column(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Box(
                                    modifier = Modifier
                                        .size(64.dp)
                                        .background(
                                            color = MaterialTheme.colorScheme.tertiaryContainer,
                                            shape = RoundedCornerShape(12.dp),
                                        ),
                                    contentAlignment = Alignment.Center,
                                ) {
                                    Text(
                                        "👨‍💻",
                                        style = MaterialTheme.typography.headlineMedium,
                                    )
                                }

                                Spacer(Modifier.width(16.dp))

                                Column {
                                    Text(
                                        "Shubham Gorai",
                                        style = MaterialTheme.typography.headlineSmall.copy(
                                            fontWeight = FontWeight.Bold
                                        ),
                                    )
                                    Text(
                                        "Developer",
                                        style = MaterialTheme.typography.titleSmall.copy(
                                            color = MaterialTheme.colorScheme.tertiary
                                        ),
                                    )
                                }
                            }

                            FlowRow(
                                modifier = Modifier.padding(start = 80.dp, top = 8.dp),
                                horizontalArrangement = Arrangement.spacedBy(8.dp),
                            ) {
                                listOf("🐙" to "GitHub", "🌍" to "Website", "✉" to "Email")
                                    .forEach { (emoji, label) ->
                                        FilledTonalIconButton(
                                            onClick = { },
                                            modifier = Modifier.size(44.dp),
                                        ) {
                                            Column(horizontalAlignment = Alignment.CenterHorizontally) {
                                                Text(emoji, style = MaterialTheme.typography.labelSmall)
                                                Text(label, style = MaterialTheme.typography.labelSmall)
                                            }
                                        }
                                    }
                            }
                        }
                    }
                }
            }

            item {
                Column(verticalArrangement = Arrangement.spacedBy(2.dp)) {
                    GroupedListItem(
                        headline = "Buy Me a Coffee",
                        supporting = "Support the developer",
                        leadingIcon = "☕",
                        trailingIcon = "↗",
                        shape = leadingItemShape(),
                    )
                    GroupedListItem(
                        headline = "Help Translate",
                        supporting = "Contribute translations on Weblate",
                        leadingIcon = "🌐",
                        trailingIcon = "↗",
                        shape = endItemShape(),
                    )
                }
            }

            item {
                GroupedListItem(
                    headline = "License",
                    supporting = "GPL-3.0 License",
                    leadingIcon = "📜",
                    shape = detachedItemShape(),
                    onClick = { showLicense = true },
                )
            }
        }
    }

    if (showLicense) {
        LicenseSheet(onDismiss = { showLicense = false })
    }
}

@Composable
private fun LicenseSheet(onDismiss: () -> Unit) {
    ModalBottomSheet(onDismissRequest = onDismiss) {
        Column(
            modifier = Modifier.padding(16.dp).padding(bottom = 32.dp),
        ) {
            Text(
                "GNU GENERAL PUBLIC LICENSE",
                style = MaterialTheme.typography.titleLarge.copy(fontWeight = FontWeight.Bold),
            )
            Text(
                "Version 3, 29 June 2007",
                style = MaterialTheme.typography.titleSmall,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
                modifier = Modifier.padding(bottom = 16.dp),
            )

            Text(
                "Copyright © 2007 Free Software Foundation, Inc.\n\n" +
                        "Everyone is permitted to copy and distribute verbatim copies " +
                        "of this license document, but changing it is not allowed.\n\n" +
                        "This program is free software: you can redistribute it and/or modify " +
                        "it under the terms of the GNU General Public License as published by " +
                        "the Free Software Foundation, either version 3 of the License, or " +
                        "(at your option) any later version.\n\n" +
                        "This program is distributed in the hope that it will be useful, " +
                        "but WITHOUT ANY WARRANTY; without even the implied warranty of " +
                        "MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. " +
                        "See the GNU General Public License for more details.\n\n" +
                        "You should have received a copy of the GNU General Public License " +
                        "along with this program. If not, see https://www.gnu.org/licenses/.",
                style = MaterialTheme.typography.bodyMedium,
                color = MaterialTheme.colorScheme.onSurfaceVariant,
            )

            Spacer(Modifier.height(16.dp))
            TextButton(onClick = onDismiss, modifier = Modifier.align(Alignment.End)) {
                Text("Close")
            }
        }
    }
}



@Preview(name = "About", showBackground = true)
@Composable
private fun AboutPreview() {
    MaterialTheme {
        Surface {
            AboutPage(
                versionName = "1.3.0",
                onBack = {},
            )
        }
    }
}

