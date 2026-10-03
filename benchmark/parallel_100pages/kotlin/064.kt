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
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
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
private const val NAME = "108ApprovalFlowen"
private const val UI_TYPE = "Map"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"
object AppTokens {
    object Colors {
        val primary = Color(0xFF111111)
        val secondary = Color(0xFF2A2A2A)
        val tertiary = Color(0xFF444444)
        val background = Color(0xFFF7F7F7)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFEDEDED)
        val outline = Color(0xFFD6D6D6)
        val success = Color(0xFF1E7D4C)
        val warning = Color(0xFFB98400)
        val error = Color(0xFFB3261E)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF0A0A0A)
        val onSurface = Color(0xFF0A0A0A)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold, lineHeight = 34.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Medium, lineHeight = 26.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium, lineHeight = 22.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal, lineHeight = 20.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium, lineHeight = 16.sp, letterSpacing = 0.sp)
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
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 4.dp, 2.dp, 0.10f)
        val level2 = ShadowSpec(3.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 12.dp, 6.dp, 0.16f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
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
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class ApprovalPin(val id: Int, val title: String, val status: String, val x: Float, val y: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val filters = remember { mutableStateListOf("Pending", "Approved") }
    val active = remember { mutableStateListOf("Pending") }
    val pins = remember {
        listOf(
            ApprovalPin(1, "Purchase Order #1042", "Pending", 0.18f, 0.35f),
            ApprovalPin(2, "Travel Request #552", "Approved", 0.52f, 0.42f),
            ApprovalPin(3, "Contract #A77", "Pending", 0.76f, 0.58f),
            ApprovalPin(4, "Budget Change #09", "Rejected", 0.33f, 0.72f)
        )
    }
    val selectedId = remember { mutableStateOf<Int?>(null) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(text = "Approval Flow", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                }
            )
        },
        bottomBar = {
            BottomAppBar(
                containerColor = MaterialTheme.colorScheme.surface,
                tonalElevation = AppTokens.ElevationMapping.level2.elevation
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Button(
                        onClick = {},
                        enabled = selectedId.value != null,
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.surfaceVariant, contentColor = MaterialTheme.colorScheme.onSurface),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier
                            .height(48.dp)
                            .weight(1f)
                    ) {
                        Text(text = "Reject", style = MaterialTheme.typography.titleMedium)
                    }
                    Spacer(modifier = Modifier.size(AppTokens.Spacing.md))
                    Button(
                        onClick = {},
                        enabled = selectedId.value != null,
                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier
                            .height(48.dp)
                            .weight(1f)
                    ) {
                        Text(text = "Approve", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = {},
                containerColor = MaterialTheme.colorScheme.primary,
                contentColor = MaterialTheme.colorScheme.onPrimary,
                shape = CircleShape
            ) {
                Text(text = "+", style = MaterialTheme.typography.headlineMedium)
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
        ) {
            LazyRow(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                contentPadding = PaddingValues(horizontal = 0.dp, vertical = 0.dp)
            ) {
                items(filters) { f ->
                    val isOn = active.contains(f)
                    FilterChip(
                        selected = isOn,
                        onClick = {
                            if (isOn) active.remove(f) else active.add(f)
                        },
                        label = {
                            Text(
                                text = f,
                                style = if (isOn) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium,
                                color = if (isOn) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface
                            )
                        },
                        shape = AppTokens.Shapes.small,
                        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
                        colors = FilterChipDefaults.filterChipColors(
                            containerColor = if (isOn) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface,
                            selectedContainerColor = MaterialTheme.colorScheme.primary
                        )
                    )
                }
            }
            BoxWithConstraints(
                modifier = Modifier
                    .fillMaxWidth()
                    .heightIn(min = 360.dp)
                    .aspectRatio(0.9f)
                    .background(AppTokens.Colors.surface, AppTokens.Shapes.large)
                    .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
            ) {
                MapGridOverlay()
                pins.filter { p ->
                    when (p.status) {
                        "Pending" -> active.contains("Pending")
                        "Approved" -> active.contains("Approved")
                        "Rejected" -> true
                        else -> true
                    }
                }.forEach { p ->
                    MapPin(
                        title = p.title,
                        status = p.status,
                        selected = selectedId.value == p.id,
                        onClick = { selectedId.value = if (selectedId.value == p.id) null else p.id },
                        modifier = Modifier.offset(
                            x = maxWidth * p.x,
                            y = maxHeight * p.y
                        )
                    )
                }
                selectedId.value?.let { id ->
                    pins.firstOrNull { it.id == id }?.let { sel ->
                        Card(
                            modifier = Modifier
                                .align(Alignment.BottomCenter)
                                .padding(AppTokens.Spacing.md),
                            shape = AppTokens.Shapes.large,
                            colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                            elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level3.elevation),
                            border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
                        ) {
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(AppTokens.Spacing.lg),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs)) {
                                    Text(text = sel.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                    Text(text = sel.status, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                                 }
                                Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                                    Button(
                                        onClick = {},
                                        colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.surfaceVariant, contentColor = MaterialTheme.colorScheme.onSurface),
                                        shape = AppTokens.Shapes.medium,
                                        modifier = Modifier.height(40.dp)
                                    ) {
                                        Text(text = "Details", style = MaterialTheme.typography.labelMedium)
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

@Composable
fun BoxScope.MapPin(title: String, status: String, selected: Boolean, onClick: () -> Unit, modifier: Modifier) {
    val base = if (status == "Approved") AppTokens.Colors.success else if (status == "Pending") AppTokens.Colors.warning else AppTokens.Colors.error
    Box(
        modifier = modifier
            .size(if (selected) 28.dp else 22.dp)
            .background(base, CircleShape)
            .border(2.dp, if (selected) AppTokens.Colors.primary else AppTokens.Colors.surface, CircleShape)
            .padding(0.dp)
            .align(Alignment.TopStart)
    ) {
        Box(modifier = Modifier.fillMaxSize())
    }
    Card(
        modifier = modifier.offset(x = 18.dp, y = (-4).dp),
        shape = AppTokens.Shapes.small,
        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
        onClick = onClick
    ) {
        Text(text = title, style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface, modifier = Modifier.padding(horizontal = AppTokens.Spacing.sm, vertical = AppTokens.Spacing.xs))
    }
}

@Composable
fun MapGridOverlay() {
    Column(modifier = Modifier
        .fillMaxSize()
        .padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.SpaceEvenly) {
        repeat(6) {
            Box(modifier = Modifier
                .fillMaxWidth()
                .height(1.dp)
                .background(AppTokens.Colors.surfaceVariant))
        }
    }
    Row(modifier = Modifier
        .fillMaxSize()
        .padding(AppTokens.Spacing.lg), horizontalArrangement = Arrangement.SpaceEvenly) {
        repeat(6) {
            Box(modifier = Modifier
                .width(1.dp)
                .fillMaxSize()
                .background(AppTokens.Colors.surfaceVariant))
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
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}
