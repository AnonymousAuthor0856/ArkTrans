package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "131*SupplyHub*en"
private const val UI_TYPE = "Grid"
private const val STYLE_THEME = "Muted Earth"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
private const val COLOR_PALETTE = "primary:#8B6B4C secondary:#C27D38 tertiary:#F2C57C background:#100C08 surface:#19110D surfaceVariant:#2A1C14 outline:#4F3A2C success:#6ECE89 warning:#E19F41 error:#D96666 onPrimary:#100C08 onSecondary:#100C08 onTertiary:#120E04 onBackground:#F7EAD8 onSurface:#FBEFE0"
private const val DENSITY_SPACING = "Medium"
private const val COMPLEXITY = "Grid,Image,LazyList"
private const val EXTRA = "Muted earth cargo grid with image placeholders"

object DesignTokens {
    object Colors {
        val primary = Color(0xFF8B6B4C)
        val secondary = Color(0xFFC27D38)
        val tertiary = Color(0xFFF2C57C)
        val background = Color(0xFF100C08)
        val surface = Color(0xFF19110D)
        val surfaceVariant = Color(0xFF2A1C14)
        val outline = Color(0xFF4F3A2C)
        val success = Color(0xFF6ECE89)
        val warning = Color(0xFFE19F41)
        val error = Color(0xFFD96666)
        val onPrimary = Color(0xFF100C08)
        val onSecondary = Color(0xFF100C08)
        val onTertiary = Color(0xFF120E04)
        val onBackground = Color(0xFFF7EAD8)
        val onSurface = Color(0xFFFBEFE0)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold, lineHeight = 34.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp, letterSpacing = 0.1.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp, letterSpacing = 0.2.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp, letterSpacing = 0.2.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.3.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(10.dp)
        val medium = RoundedCornerShape(18.dp)
        val large = RoundedCornerShape(26.dp)
    }
    object Spacing {
        val xxs = 6.dp
        val xs = 10.dp
        val sm = 14.dp
        val md = 18.dp
        val lg = 26.dp
        val xl = 36.dp
        val xxl = 48.dp
        val xxxl = 62.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.18f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.22f)
        val level3 = ShadowSpec(12.dp, 12.dp, 6.dp, 0.26f)
        val level4 = ShadowSpec(18.dp, 18.dp, 8.dp, 0.3f)
        val level5 = ShadowSpec(24.dp, 24.dp, 10.dp, 0.34f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = DesignTokens.Colors.primary,
    onPrimary = DesignTokens.Colors.onPrimary,
    secondary = DesignTokens.Colors.secondary,
    onSecondary = DesignTokens.Colors.onSecondary,
    tertiary = DesignTokens.Colors.tertiary,
    onTertiary = DesignTokens.Colors.onTertiary,
    background = DesignTokens.Colors.background,
    onBackground = DesignTokens.Colors.onBackground,
    surface = DesignTokens.Colors.surface,
    onSurface = DesignTokens.Colors.onSurface,
    surfaceVariant = DesignTokens.Colors.surfaceVariant,
    outline = DesignTokens.Colors.outline,
    error = DesignTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = DesignTokens.TypographyTokens.display,
    headlineMedium = DesignTokens.TypographyTokens.headline,
    titleMedium = DesignTokens.TypographyTokens.title,
    bodyMedium = DesignTokens.TypographyTokens.body,
    labelMedium = DesignTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            extraSmall = DesignTokens.Shapes.small,
            small = DesignTokens.Shapes.small,
            medium = DesignTokens.Shapes.medium,
            large = DesignTokens.Shapes.large,
            extraLarge = DesignTokens.Shapes.large
        ),
        content = content
    )
}

data class CargoCard(val title: String, val id: String, val fill: String)
data class ManifestEntry(val origin: String, val destination: String, val status: String)
data class HubFilter(val label: String)

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                RootScreen()
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val cards = listOf(
        CargoCard("Copper stack", "SH-014", "78%"),
        CargoCard("Fiber reels", "SH-022", "64%"),
        CargoCard("Agro crates", "SH-031", "92%"),
        CargoCard("Glass kits", "SH-045", "51%"),
        CargoCard("Steel mesh", "SH-057", "88%"),
        CargoCard("Raw silica", "SH-063", "43%")
    )
    val manifest = listOf(
        ManifestEntry("Santiago", "Lima", "Boarding"),
        ManifestEntry("Mecca", "Algiers", "At dock"),
        ManifestEntry("Reykjavík", "Oslo", "Delayed"),
        ManifestEntry("Perth", "Jakarta", "In flight")
    )
    val filters = listOf(HubFilter("All"), HubFilter("Atlantic"), HubFilter("Pacific"), HubFilter("Inland"))
    val activeFilter = remember { mutableStateOf(filters.first().label) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = MaterialTheme.colorScheme.background,
        topBar = {
            CenterAlignedTopAppBar(
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = MaterialTheme.colorScheme.surface.copy(alpha = 0.95f)),
                title = {
                    Column(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(text = "SupplyHub", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "Logistics grid", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                    }
                },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(26.dp).background(MaterialTheme.colorScheme.surfaceVariant, CircleShape))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(26.dp).background(MaterialTheme.colorScheme.surfaceVariant, CircleShape))
                    }
                }
            )
        },
        bottomBar = {
            Surface(
                color = MaterialTheme.colorScheme.surface,
                tonalElevation = DesignTokens.ElevationMapping.level3.elevation,
                shadowElevation = DesignTokens.ElevationMapping.level3.elevation
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = DesignTokens.Spacing.lg, vertical = DesignTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                        Text(text = "Manifest filter", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = activeFilter.value, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Button(
                        onClick = {},
                        shape = DesignTokens.Shapes.medium,
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary),
                        contentPadding = PaddingValues(horizontal = DesignTokens.Spacing.xl, vertical = DesignTokens.Spacing.xs)
                    ) {
                        Text(text = "Dispatch", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onPrimary)
                    }
                }
            }
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = DesignTokens.Spacing.lg, vertical = DesignTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.lg)
        ) {
            item {
                Row(horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xs), modifier = Modifier.fillMaxWidth()) {
                    filters.forEach { filter ->
                        val active = activeFilter.value == filter.label
                        Button(
                            onClick = { activeFilter.value = filter.label },
                            shape = DesignTokens.Shapes.small,
                            colors = ButtonDefaults.buttonColors(containerColor = if (active) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surfaceVariant),
                            contentPadding = PaddingValues(horizontal = DesignTokens.Spacing.sm, vertical = DesignTokens.Spacing.xxs)
                        ) {
                            Text(text = filter.label, style = MaterialTheme.typography.labelMedium, color = if (active) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface)
                        }
                    }
                }
            }
            item {
                Text(text = "Cargo grid", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
            }
            item {
                LazyVerticalGrid(
                    columns = GridCells.Fixed(2),
                    modifier = Modifier.height(320.dp),
                    verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm),
                    horizontalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm),
                    contentPadding = PaddingValues(0.dp)
                ) {
                    items(cards) { card ->
                        Column(
                            modifier = Modifier
                                .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.92f), DesignTokens.Shapes.medium)
                                .padding(DesignTokens.Spacing.md),
                            verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.sm)
                        ) {
                            Box(
                                modifier = Modifier
                                    .height(90.dp)
                                    .fillMaxWidth()
                                    .background(MaterialTheme.colorScheme.surface, DesignTokens.Shapes.small),
                                contentAlignment = Alignment.Center
                            ) {
                                Box(
                                    modifier = Modifier
                                        .size(60.dp)
                                        .background(MaterialTheme.colorScheme.tertiary.copy(alpha = 0.4f), CircleShape)
                                )
                            }
                            Column(verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                                Text(text = card.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                Text(text = card.id, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface.copy(alpha = 0.7f))
                                Text(text = "Fill ${card.fill}", style = MaterialTheme.typography.labelMedium, color = DesignTokens.Colors.success)
                            }
                        }
                    }
                }
            }
            item {
                Text(text = "Route manifest", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
            }
            items(manifest) { entry ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .background(MaterialTheme.colorScheme.surfaceVariant.copy(alpha = 0.85f), DesignTokens.Shapes.medium)
                        .padding(DesignTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Column(verticalArrangement = Arrangement.spacedBy(DesignTokens.Spacing.xxs)) {
                        Text(text = "${entry.origin} → ${entry.destination}", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = entry.status, style = MaterialTheme.typography.bodyMedium, color = when (entry.status) {
                            "Delayed" -> DesignTokens.Colors.warning
                            "In flight" -> DesignTokens.Colors.success
                            else -> MaterialTheme.colorScheme.onSurface.copy(alpha = 0.8f)
                        })
                    }
                    Button(
                        onClick = {},
                        shape = DesignTokens.Shapes.small,
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary),
                        contentPadding = PaddingValues(horizontal = DesignTokens.Spacing.sm, vertical = DesignTokens.Spacing.xs)
                    ) {
                        Text(text = "Details", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSecondary)
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}