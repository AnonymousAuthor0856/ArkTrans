package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxScope
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
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

private const val NAME = "112*ClientDetail*en"
private const val UI_TYPE = "Dashboard"
private const val STYLE_THEME = "Warm Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFF7043)
        val secondary = Color(0xFFFFB74D)
        val tertiary = Color(0xFFFFD54F)
        val background = Color(0xFFFFF8E1)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFECB3)
        val outline = Color(0xFFE0C097)
        val success = Color(0xFF43A047)
        val warning = Color(0xFFFBC02D)
        val error = Color(0xFFE53935)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF3E2723)
        val onTertiary = Color(0xFF3E2723)
        val onBackground = Color(0xFF3E2723)
        val onSurface = Color(0xFF3E2723)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 4.dp, 2.dp, 0.1f)
        val level2 = ShadowSpec(3.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 12.dp, 6.dp, 0.16f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayLarge = AppTokens.TypographyTokens.display,
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class Client(val id: Int, val name: String, val region: String, val level: String, val x: Float, val y: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val clients = listOf(
        Client(1, "Sunrise Tech", "Shanghai", "A", 0.2f, 0.3f),
        Client(2, "Delta Logistics", "Beijing", "B", 0.5f, 0.45f),
        Client(3, "Oceanic Foods", "Guangzhou", "A", 0.72f, 0.6f),
        Client(4, "Horizon Ltd.", "Chengdu", "C", 0.33f, 0.75f)
    )
    val selectedId = remember { mutableStateOf<Int?>(null) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(text = "Client Detail", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                }
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            Box(
                modifier = Modifier.fillMaxWidth().height(200.dp).background(
                    Brush.linearGradient(listOf(AppTokens.Colors.secondary, AppTokens.Colors.primary)),
                    AppTokens.Shapes.large
                ),
                contentAlignment = Alignment.Center
            ) {
                Text(text = "Regional Client Map", style = MaterialTheme.typography.headlineMedium, color = AppTokens.Colors.onPrimary)
            }
            BoxWithConstraints(
                modifier = Modifier.fillMaxWidth().heightIn(min = 360.dp).aspectRatio(0.9f).background(AppTokens.Colors.surface, AppTokens.Shapes.large).border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
            ) {
                MapGridOverlay()
                clients.forEach { c ->
                    MapMarker(
                        label = c.name,
                        level = c.level,
                        selected = selectedId.value == c.id,
                        onClick = { selectedId.value = if (selectedId.value == c.id) null else c.id },
                        modifier = Modifier.offset(
                            x = maxWidth * c.x,
                            y = maxHeight * c.y
                        )
                    )
                }
            }
            LazyColumn(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md), contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)) {
                items(clients) { c ->
                    Card(
                        modifier = Modifier.fillMaxWidth(),
                        shape = AppTokens.Shapes.medium,
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
                        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
                    ) {
                        Row(
                            modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg),
                            horizontalArrangement = Arrangement.SpaceBetween,
                            verticalAlignment = Alignment.CenterVertically
                        ) {
                            Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                                Text(text = c.name, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                Text(text = c.region, style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                            }
                            Text(text = "Level ${c.level}", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.primary)
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun BoxScope.MapMarker(label: String, level: String, selected: Boolean, onClick: () -> Unit, modifier: Modifier) {
    val color = when (level) {
        "A" -> AppTokens.Colors.primary
        "B" -> AppTokens.Colors.secondary
        else -> AppTokens.Colors.tertiary
    }
    Box(
        modifier = modifier.size(if (selected) 28.dp else 22.dp).background(color, CircleShape).border(2.dp, if (selected) AppTokens.Colors.onPrimary else AppTokens.Colors.surface, CircleShape).align(Alignment.TopStart)
    )
    Card(
        onClick = onClick,
        modifier = modifier.offset(x = 20.dp, y = (-4).dp),
        shape = AppTokens.Shapes.small,
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surfaceVariant),
        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
    ) {
        Text(text = label, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface, modifier = Modifier.padding(horizontal = AppTokens.Spacing.sm, vertical = AppTokens.Spacing.xs))
    }
}

@Composable
fun MapGridOverlay() {
    Column(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.SpaceEvenly) {
        repeat(6) {
            Box(modifier = Modifier.fillMaxWidth().height(1.dp).background(AppTokens.Colors.surfaceVariant))
        }
    }
    Row(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg), horizontalArrangement = Arrangement.SpaceEvenly) {
        repeat(6) {
            Box(modifier = Modifier.width(1.dp).fillMaxSize().background(AppTokens.Colors.surfaceVariant))
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
